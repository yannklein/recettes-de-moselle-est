import "bootstrap";

import { initMapbox } from 'plugins/init_mapbox';

const mapboxElement = document.querySelector('#map');
if(mapboxElement) {
  initMapbox(mapboxElement);
}
