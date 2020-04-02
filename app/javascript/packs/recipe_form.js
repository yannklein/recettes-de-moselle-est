const initRecipeForm = () => {
  const ingrList = document.querySelector(".ingr-input .form-group");
  const stepList = document.querySelector(".step-input .form-group");

  const ingrBtn = document.querySelector(".new-ingr-btn");
  const stepBtn = document.querySelector(".new-step-btn");

  const newIngrInput = `<li><input class="text required form-control" required="required" aria-required="true" type="text" value="" name="recipe[ingredient][]" id="recipe_"></li>`;
  const newStepInput = `<li><input class="text required form-control" required="required" aria-required="true" type="text" value="" name="recipe[prep_step][]" id="recipe_"></li>`;
  ingrBtn.addEventListener("click", (event) => {
    event.preventDefault();
    ingrList.insertAdjacentHTML("beforeend", newIngrInput);
  });

  stepBtn.addEventListener("click", (event) => {
    event.preventDefault();
    stepList.insertAdjacentHTML("beforeend", newStepInput);
  });
}

export { initRecipeForm };
