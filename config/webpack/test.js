process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

module.exports = environment.toWebpackConfig()

/*<script>
'use strict';

console.log('test');
console.log(1+1);
window.alert('おはようございます。');
document.getElementById('choice').textContent = new Date();
console.log(document.getElementById('choice').textContent);
const answer = window.prompt('ヘルプを見ますか？');
if (answer === 'yes') {
  window.alert('タップでジャンプ、障害物をよけます。');
} else if(answer === 'no') {
  window.alert('ゲーム起動中．．．');
} else {
  window.alert('yesかnoでお答えください。');
}
const number = Math.floor(Math.random() * 6);
const answer = parseInt(window.prompt('数当てゲーム。0～5の数字を入力してね。'));
let message;
if(answer === number) {
  message = 'あたり！';
} else if(answer < number) {
  message = '残念でした！もっと大きい';
} else if(answer > number) {
  message = '残念でした！もっと小さい';
} else {
  message = '0～5の数字を入力してね。';
}

const hour = new Date().getHours();

if(hour >= 19 && hour < 21) {
  window.alert('お弁当30%OFF！');
} else if(hour === 9 || hour === 15) {
  window.alert('お弁当1個買ったら1個おまけ！');
} else {
  window.alert('お弁当いかがですか');
}
let i = 1;
while(i <= 10) {
  console.log(i + '枚');
  i += 1;
}
let enemy = 100;
let count = 0;

window.alert('戦闘スタート！');
while(enemy > 0) {
  const attack = Math.floor(Math.random() * 30) + 1;
  console.log('モンスターに' + attack + 'のダメージ！');
  enemy -= attack;
  count += 1;
}
console.log(count + '回でモンスターを倒した！');

function total(price) {
  const tax = 0.1;
  return price + price * tax;
}

console.log('コーヒーメーカーの値段は' + total(8000) + '円（税込）です。');
document.getElementById('output').textContent = 'コーヒーメーカーの値段は' + total(8000) + '円（税込）です。';
document.getElementById('output2').textContent = 'コーヒーフィルタの値段は' + total(200) + '円（税込）です。';
document.getElementById('output3').textContent = 'コーヒー豆の値段は' + total(1000) + '円（税込）です。';

function fizzbuzz(num) {
  if(num % 3 === 0 && num % 5 === 0) {
    return 'fizzbuzz';
  } else if(num % 3 === 0) {
    return 'fizz';
  } else if(num % 5 === 0) {
    return 'buzz';
  } else {
    return num;
  }
}

let i = 1;
while(i <= 30) {
  console.log(fizzbuzz(i));
  i += 1;
}
let todo = ['デザインカンプ作成', 'データ整理', '勉強会申し込み', '牛乳買う'];
todo.push('歯医者に行く');
for(let item of todo) {
  const li = `<li>${item}</li>`;
  document.getElementById('list').insertAdjacentHTML('beforeend', li);
}
let jsbook = {title: 'JavaScript入門', price: 2500, stock: 3};
document.getElementById('form').onsubmit = function(event) {
  event.preventDefault();
  const search = document.getElementById('form').word.value;
  document.getElementById('output').textContent = `[${search}]の検索中...`;
};

const now = new Date();
const year = now.getFullYear();
const month = now.getMonth();
const date = now.getDate();
const hour = now.getHours();
const min = now.getMinutes();
let ampm ='';
if(hour < 12) {
  ampm = 'a.m.';
} else {
  ampm = 'p.m.';
}

</script>
*/