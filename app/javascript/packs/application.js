import "bootstrap";

import { initMapbox } from 'plugins/init_mapbox';

import { initRecipeForm } from './recipe_form';

const mapboxElement = document.querySelector('#map');
if(mapboxElement) {
  initMapbox(mapboxElement);
}

const recipeFormElement = document.querySelector('.recipe-form');
if(recipeFormElement) {
  initRecipeForm();
}
