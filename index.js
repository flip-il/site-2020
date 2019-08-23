/**
 */
import { Elm } from './src/Main.elm'
import background from './src/assets/background.svg'

Elm.Main.init({
  node: document.querySelector('main'),
  flags: {
    backgroundSrc: background
  }
})
