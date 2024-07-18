process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

module.exports = environment.toWebpackConfig()

console.log('test');
console.log(1+1);
window.alert('おはようございます。');
document.getElementById('choice').textContent = new Date();
console.log(document.getElementById('choice').textContent);
if(window.confirm('ゲームスタート！準備はいい？')) {
  console.log('ゲームを開始します。');
} else {
  console.log('ゲームを終了します。');
}
