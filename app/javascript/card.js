const pay = () => {
  const form = document.getElementById('charge-form');
  // 1. フォームが存在しないページでは処理を終了する（エラー防止）
  if (!form) return;

  const publicKey = form.dataset.publicKey;
  const payjp = Payjp(publicKey);

  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  if (document.getElementById('number-form')) {
    numberElement.mount('#number-form');
  }
  if (document.getElementById('expiry-form')) {
    expiryElement.mount('#expiry-form');
  }
  if (document.getElementById('cvc-form')) {
    cvcElement.mount('#cvc-form');
  }

  // 2. formの再定義
  form.addEventListener("submit", (e) => {
    e.preventDefault();

    const submitButton = form.querySelector('input[type="submit"]');
    if (submitButton) submitButton.disabled = true;

    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        // エラー時は何もしない（トークンを送らず送信し、Rails側のバリデーションに任せる）
      } else {
        const token = response.id;
        // 既存のトークンがあれば削除
        const oldToken = document.getElementsByName('token')[0];
        if (oldToken) oldToken.remove();

        const tokenObj = `<input value="${token}" name="token" type="hidden">`;
        form.insertAdjacentHTML("beforeend", tokenObj);
      }
      
      form.submit();
    });
  });
};

// 3. 発火タイミングの整理
// ページが読み込まれた時(turbo:load)と、バリデーションエラーで再描画された時(turbo:render)
window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);
