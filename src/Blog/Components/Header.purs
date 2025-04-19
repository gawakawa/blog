module Blog.Components.Header where

import Prelude

import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

header :: forall w i. HH.HTML w i
header =
  HH.header_
    [ HH.h1_ [ HH.text "ι's home" ]
    , HH.p [ HP.class_ (HH.ClassName "subtitle") ] [ HH.text "( 仮 )" ]
    ]
