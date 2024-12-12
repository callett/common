let your_url = " ";
let arg;
if (typeof $argument != 'undefined') {
    arg = Object.fromEntries($argument.split('&').map(item => item.split('=')));
};
// 检查配置
const URL = arg?.url || your_url;
if (!URL) $notification.post('配置错误❌', 'URL有误或无');
// 面板
let panel = {};
// panel.title = arg?.title || 'CAT VPS';
panel.title = 'VPS监控';
panel.icon = arg?.icon;
let shifts = {
    '1': arg?.low,
    '2': arg?.mid,
    '3': arg?.high
};
// 时间
let time = new Date();
const t = time.getHours() + ':' + time.getMinutes() + ':' + time.getSeconds();
console.log(t)
// 发送请求获取信息
const request = {
    url: URL,
    timeout: 3000
};
$httpClient.get(request, function(error, response, data) {
    if (error) {
        console.log('error: '+error);
        $done({title:'啊呃～', content:'完蛋了，出错了！看看是不是端口没打开？'+error});
    } else  {
        const Data = JSON.parse(data);
        const col = Diydecide(0, 30 ,70, parseInt(Data.mem));
        console.log(Data);
        panel["icon-color"] = shifts[col];
        panel.content =
        // `统计时间：${Data.last_exec_time}\n` +
        `CPU: ${Data.cpu}\n` +
        `内存: ${Data.mem}\n` +
        `入站: ${Data.in}\n` +
        `出站: ${Data.out}\n` +
        `用量: ${Data.all}\n` +
        `每月流量: ${arg?.total}\n` +
        `服务到期时间：${arg?.ddl}`;
        $done(panel);
    }
});

//确定变量所在区间
function Diydecide(x,y,z,item) {
    let array = [x,y,z]
    array.push(item)
    return array.sort((a,b) => a-b).findIndex(i => i === item)
}