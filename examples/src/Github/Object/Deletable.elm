module Github.Object.Deletable exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (FragmentSelectionSet(FragmentSelectionSet), SelectionSet(SelectionSet))
import Json.Decode as Decode


baseSelection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Deletable
baseSelection constructor =
    Object.object constructor


selection : (Maybe typeSpecific -> a -> constructor) -> List (FragmentSelectionSet typeSpecific Github.Object.Deletable) -> SelectionSet (a -> constructor) Github.Object.Deletable
selection constructor typeSpecificDecoders =
    Object.polymorphicObject typeSpecificDecoders constructor


onCommitComment : SelectionSet selection Github.Object.CommitComment -> FragmentSelectionSet selection Github.Object.Deletable
onCommitComment (SelectionSet fields decoder) =
    FragmentSelectionSet "CommitComment" fields decoder


onGistComment : SelectionSet selection Github.Object.GistComment -> FragmentSelectionSet selection Github.Object.Deletable
onGistComment (SelectionSet fields decoder) =
    FragmentSelectionSet "GistComment" fields decoder


onIssueComment : SelectionSet selection Github.Object.IssueComment -> FragmentSelectionSet selection Github.Object.Deletable
onIssueComment (SelectionSet fields decoder) =
    FragmentSelectionSet "IssueComment" fields decoder


onPullRequestReview : SelectionSet selection Github.Object.PullRequestReview -> FragmentSelectionSet selection Github.Object.Deletable
onPullRequestReview (SelectionSet fields decoder) =
    FragmentSelectionSet "PullRequestReview" fields decoder


onPullRequestReviewComment : SelectionSet selection Github.Object.PullRequestReviewComment -> FragmentSelectionSet selection Github.Object.Deletable
onPullRequestReviewComment (SelectionSet fields decoder) =
    FragmentSelectionSet "PullRequestReviewComment" fields decoder


{-| Check if the current viewer can delete this object.
-}
viewerCanDelete : FieldDecoder Bool Github.Object.Deletable
viewerCanDelete =
    Object.fieldDecoder "viewerCanDelete" [] Decode.bool
