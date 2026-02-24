const price = () => {
  const priceInput = document.getElementById("item-price");
  if (priceInput) {
    const calculateAndDisplay = () => {
      const inputValue = priceInput.value;
      const addTaxDom = document.getElementById("add-tax-price");
      const profitDom = document.getElementById("profit");

      const tax = Math.floor(inputValue * 0.1);
      addTaxDom.innerHTML = tax;

      const profit = inputValue - tax;
      profitDom.innerHTML = profit;
    };

    priceInput.addEventListener("input", calculateAndDisplay);

    if (priceInput.value) {
    calculateAndDisplay();
    }
  }
};

// ページが読み込まれたとき、およびTurboによる遷移時に発火させる
window.addEventListener('turbo:load', price);
window.addEventListener("turbo:render", price);