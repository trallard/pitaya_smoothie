module App

open Elmish
open Elmish.React
open Fable.Core.JsInterop
importAll "@shopify/polaris/styles.css"

let elements = [
  (Navigation.view, "fable-polaris-navigation", "polaris_navigation_loaded")
  //(Avatar.view, "fable-polaris-avatar", "polaris_avatar_loaded")
  (AccountConnection.view, "fable-polaris-accountConnection", "polaris_accountConnection_loaded")
  //(ActionList.view, "fable-polaris-actionList", "polaris_actionList_loaded")
  //(Autocomplete.view, "fable-polaris-autocomplete", "polaris_autocomplete_loaded")
]

List.iter (fun x ->
  match x with
    | (a, b, c) ->
      Browser.Dom.window?(c)
        <-
          fun _ ->
              Program.mkSimple ignore (fun _ -> ignore) a
                      |> Program.withReactBatched b
                      |> Program.withConsoleTrace
                      |> Program.run
) elements