process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

module.exports = environment.toWebpackConfig()

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
