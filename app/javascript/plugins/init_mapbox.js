import mapboxgl from 'mapbox-gl/dist/mapbox-gl';

const createMarker = (data, map, markerIcon) => {

  // console.log(data);
  // add markers to map
  data.forEach((marker) => {

    // create a HTML element for each feature
    var el = document.createElement('div');
    el.className = 'marker';

    // make a marker for each feature and add to the map
    // console.log(marker.properties.description);
    const popupContent = marker.properties.description.map((content) => {
      return `
      <a href="${content.url}">
        <div class="marker-recipe-info" style="background-image: url('${content.photo}')">
          <p>${content.name}</p>
        </div>
      </a>`
    });

    const popup = `
      <h3>
        ${marker.properties.title }
      </h3>
      ${(popupContent.length === 0) ? `<p class="no-recipe">Pas encore de recette!</p>` : ""}
      <div class="marker-recipe">
        ${popupContent.join("")}
      </div>`;

    new mapboxgl.Marker(el)
      .setLngLat(marker.geometry.coordinates)
      .setPopup(
        new mapboxgl.Popup({ offset: 25, maxWidth: 'none' }).setHTML(popup)
        )
      .addTo(map);
  });

  document.querySelectorAll('.marker').forEach((marker) => {
    marker.style.backgroundImage = `url('.${markerIcon}')`;
  });
}

const fetchMarkers = (map, markerIcon) => {
  fetch('./recipes.json')
  .then(response => response.json())
  .then((data) => {
    createMarker(data, map, markerIcon);
  })
}

const initMapbox = (mapboxElement) => {
  const markerIcon = mapboxElement.dataset.icon;
  mapboxgl.accessToken = 'pk.eyJ1IjoieWFubmx1Y2tsZWluIiwiYSI6ImNqcnZmeHQwaDAxb2o0NGx2bG1tOWgwNGIifQ.q4zhKOCoH7nDIJNm88leXg';
  const map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v11',
    center: [6.5527641, 49.0983839],
    zoom: 9,
  });

  fetchMarkers(map, markerIcon);

  map.on('load', function() {
    // console.log(map.style._layers);
    const mslCenter = [6.75, 49.02];
    const mslWidth = 1.76;
    const mslHeight = mslWidth*0.55;
    const coord = [
          [mslCenter[0] - mslWidth/2, mslCenter[1] + mslHeight/2],
          [mslCenter[0] + mslWidth/2, mslCenter[1] + mslHeight/2],
          [mslCenter[0] + mslWidth/2, mslCenter[1] - mslHeight/2],
          [mslCenter[0] - mslWidth/2, mslCenter[1] - mslHeight/2]
        ];
    console.log(coord);
    map.addSource('carte-moselle', {
      'type': 'image',
      'url': mapboxElement.dataset.moselle,
      'coordinates': coord
    });
    map.addLayer({
      'id': 'carte-moselle',
      'source': 'carte-moselle',
      'sourceLayer': "place_label",
      'type': 'raster',
      'paint': { 'raster-opacity': 0.85 }
    });
  });
};

export { initMapbox };
