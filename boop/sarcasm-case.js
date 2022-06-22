/**
  {
    "api": 1,
    "name": "Sarcasm-case",
    "description": "YoUr DeScRiPtIoN hErE",
    "author": "Kellen Frodelius-Fujimoto (@rakenodiax)",
    "icon": "html",
    "tags": "text"
  }
**/

const sarcasmify = (text) => [...text].map((character, index) => index % 2 === 0 ? character.toLocaleUpperCase() : character.toLocaleLowerCase()).join('');

function main(state) {
  state.fullText = sarcasmify(state.fullText);
}