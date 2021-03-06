module Graphqelm.Generator.OptionalArgs exposing (Result, generate)

import Graphqelm.Generator.Decoder
import Graphqelm.Generator.Let exposing (LetBinding)
import Graphqelm.Parser.CamelCaseName as CamelCaseName exposing (CamelCaseName)
import Graphqelm.Parser.Type as Type
import Interpolate exposing (interpolate)


type alias Result =
    { annotatedArg :
        String
        ->
            { annotation : String
            , arg : String
            }
    , letBindings : List LetBinding
    , typeAlias : { body : String, suffix : String }
    }


type alias OptionalArg =
    { name : CamelCaseName
    , typeOf : Type.ReferrableType
    }


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


generate : List String -> List Type.Arg -> Maybe Result
generate apiSubmodule allArgs =
    case List.filterMap optionalArgOrNothing allArgs of
        [] ->
            Nothing

        optionalArgs ->
            Just
                { annotatedArg =
                    \fieldName ->
                        { annotation = annotation fieldName
                        , arg = "fillInOptionals"
                        }
                , letBindings =
                    [ "filledInOptionals" => ("fillInOptionals " ++ emptyRecord optionalArgs)
                    , "optionalArgs"
                        => (argValues apiSubmodule optionalArgs
                                ++ "\n                |> List.filterMap identity"
                           )
                    ]
                , typeAlias = { suffix = "OptionalArguments", body = typeAlias apiSubmodule optionalArgs }
                }


argValues : List String -> List OptionalArg -> String
argValues apiSubmodule optionalArgs =
    let
        values =
            optionalArgs
                |> List.map (argValue apiSubmodule)
                |> String.join ", "
    in
    interpolate "[ {0} ]" [ values ]


argValue : List String -> OptionalArg -> String
argValue apiSubmodule { name, typeOf } =
    interpolate
        """Argument.optional "{0}" filledInOptionals.{1} ({2})"""
        [ CamelCaseName.raw name
        , CamelCaseName.normalized name
        , Graphqelm.Generator.Decoder.generateEncoder apiSubmodule (Type.TypeReference typeOf Type.NonNullable)
        ]


emptyRecord : List OptionalArg -> String
emptyRecord optionalArgs =
    let
        recordEntries =
            List.map (\{ name } -> CamelCaseName.normalized name ++ " = Absent") optionalArgs
                |> String.join ", "
    in
    interpolate "{ {0} }" [ recordEntries ]


annotation : String -> String
annotation fieldName =
    interpolate "({0}OptionalArguments -> {0}OptionalArguments)"
        [ fieldName ]


typeAlias : List String -> List OptionalArg -> String
typeAlias apiSubmodule optionalArgs =
    List.map
        (\{ name, typeOf } ->
            CamelCaseName.normalized name
                ++ " : OptionalArgument "
                ++ Graphqelm.Generator.Decoder.generateType apiSubmodule (Type.TypeReference typeOf Type.NonNullable)
        )
        optionalArgs
        |> String.join ", "
        |> List.singleton
        |> interpolate "{ {0} }"


optionalArgOrNothing : Type.Arg -> Maybe OptionalArg
optionalArgOrNothing { name, typeRef } =
    case typeRef of
        Type.TypeReference referrableType Type.NonNullable ->
            Nothing

        Type.TypeReference referrableType Type.Nullable ->
            Just { name = name, typeOf = referrableType }
