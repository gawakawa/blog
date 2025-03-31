module Blog.Components.Footer where

import Prelude

import Halogen.HTML as HH

footer :: forall w i. HH.HTML w i
footer = 
  HH.footer_
    [ HH.p_ [ HH.text "© 2025 マイブログ" ]
    ]