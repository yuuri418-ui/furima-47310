const price = () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");

    // 手数料（10%）の計算。Math.floorで小数点以下を切り捨てます。
    const tax = Math.floor(inputValue * 0.1);
    addTaxDom.innerHTML = tax;

    // 利益の計算
    const profit = inputValue - tax;
    profitDom.innerHTML = profit;
  })
};

// ページが読み込まれたとき、およびTurboによる遷移時に発火させる
window.addEventListener('turbo:load', price);
window.addEventListener("turbo:render", price);