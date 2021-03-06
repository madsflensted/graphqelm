-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module Github.Union.PushAllowanceActor exposing (..)

import Github.InputObject
import Github.Interface
import Github.Object
import Github.Scalar
import Github.Union
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Internal.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Internal.Builder.Object as Object
import Graphqelm.Internal.Encode as Encode exposing (Value)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (FragmentSelectionSet(FragmentSelectionSet), SelectionSet(SelectionSet))
import Json.Decode as Decode


selection : (Maybe typeSpecific -> constructor) -> List (FragmentSelectionSet typeSpecific Github.Union.PushAllowanceActor) -> SelectionSet constructor Github.Union.PushAllowanceActor
selection constructor typeSpecificDecoders =
    Object.unionSelection typeSpecificDecoders constructor


onUser : SelectionSet decodesTo Github.Object.User -> FragmentSelectionSet decodesTo Github.Union.PushAllowanceActor
onUser (SelectionSet fields decoder) =
    FragmentSelectionSet "User" fields decoder


onTeam : SelectionSet decodesTo Github.Object.Team -> FragmentSelectionSet decodesTo Github.Union.PushAllowanceActor
onTeam (SelectionSet fields decoder) =
    FragmentSelectionSet "Team" fields decoder
