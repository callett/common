const $ = new Env('Ip-Info')

const ICONS = [
	['AC', '🇦🇨'], ['AD', '🇦🇩'], ['AE', '🇦🇪'], ['AF', '🇦🇫'], ['AG', '🇦🇬'], ['AI', '🇦🇮'], ['AL', '🇦🇱'], ['AM', '🇦🇲'], ['AO', '🇦🇴'], ['AQ', '🇦🇶'], ['AR', '🇦🇷'], ['AS', '🇦🇸'], ['AT', '🇦🇹'], ['AU', '🇦🇺'], ['AW', '🇦🇼'], ['AX', '🇦🇽'], ['AZ', '🇦🇿'], ['BA', '🇧🇦'], ['BB', '🇧🇧'], ['BD', '🇧🇩'], ['BE', '🇧🇪'], ['BF', '🇧🇫'], ['BG', '🇧🇬'], ['BH', '🇧🇭'], ['BI', '🇧🇮'], ['BJ', '🇧🇯'], ['BM', '🇧🇲'], ['BN', '🇧🇳'], ['BO', '🇧🇴'], ['BR', '🇧🇷'], ['BS', '🇧🇸'], ['BT', '🇧🇹'], ['BV', '🇧🇻'], ['BW', '🇧🇼'], ['BY', '🇧🇾'], ['BZ', '🇧🇿'], ['CA', '🇨🇦'], ['CD', '🇨🇩'], ['CF', '🇨🇫'], ['CG', '🇨🇬'], ['CH', '🇨🇭'], ['CI', '🇨🇮'], ['CK', '🇨🇰'], ['CL', '🇨🇱'], ['CM', '🇨🇲'], ['CN', '🇨🇳'], ['CO', '🇨🇴'], ['CP', '🇫🇷'], ['CR', '🇨🇷'], ['CU', '🇨🇺'], ['CV', '🇨🇻'], ['CW', '🇨🇼'], ['CX', '🇨🇽'], ['CY', '🇨🇾'], ['CZ', '🇨🇿'], ['DE', '🇩🇪'], ['DG', '🇩🇬'], ['DJ', '🇩🇯'], ['DK', '🇩🇰'], ['DM', '🇩🇲'], ['DO', '🇩🇴'], ['DZ', '🇩🇿'], ['EA', '🇪🇦'], ['EC', '🇪🇨'], ['EE', '🇪🇪'], ['EG', '🇪🇬'], ['EH', '🇪🇭'], ['ER', '🇪🇷'], ['ES', '🇪🇸'], ['ET', '🇪🇹'], ['EU', '🇪🇺'], ['FI', '🇫🇮'], ['FJ', '🇫🇯'], ['FK', '🇫🇰'], ['FM', '🇫🇲'], ['FO', '🇫🇴'], ['FR', '🇫🇷'], ['GA', '🇬🇦'], ['GB', '🇬🇧'], ['GD', '🇬🇩'], ['GE', '🇬🇪'], ['GF', '🇬🇫'], ['GH', '🇬🇭'], ['GI', '🇬🇮'], ['GL', '🇬🇱'], ['GM', '🇬🇲'], ['GN', '🇬🇳'], ['GP', '🇬🇵'], ['GR', '🇬🇷'], ['GT', '🇬🇹'], ['GU', '🇬🇺'], ['GW', '🇬🇼'], ['GY', '🇬🇾'], ['HK', '🇭🇰'], ['HN', '🇭🇳'], ['HR', '🇭🇷'], ['HT', '🇭🇹'], ['HU', '🇭🇺'], ['ID', '🇮🇩'], ['IE', '🇮🇪'], ['IL', '🇮🇱'], ['IM', '🇮🇲'], ['IN', '🇮🇳'], ['IR', '🇮🇷'], ['IS', '🇮🇸'], ['IT', '🇮🇹'], ['JM', '🇯🇲'], ['JO', '🇯🇴'], ['JP', '🇯🇵'], ['KE', '🇰🇪'], ['KG', '🇰🇬'], ['KH', '🇰🇭'], ['KI', '🇰🇮'], ['KM', '🇰🇲'], ['KN', '🇰🇳'], ['KP', '🇰🇵'], ['KR', '🇰🇷'], ['KW', '🇰🇼'], ['KY', '🇰🇾'], ['KZ', '🇰🇿'], ['LA', '🇱🇦'], ['LB', '🇱🇧'], ['LC', '🇱🇨'], ['LI', '🇱🇮'], ['LK', '🇱🇰'], ['LR', '🇱🇷'], ['LS', '🇱🇸'], ['LT', '🇱🇹'], ['LU', '🇱🇺'], ['LV', '🇱🇻'], ['LY', '🇱🇾'], ['MA', '🇲🇦'], ['MC', '🇲🇨'], ['MD', '🇲🇩'], ['MG', '🇲🇬'], ['MH', '🇲🇭'], ['MK', '🇲🇰'], ['ML', '🇲🇱'], ['MM', '🇲🇲'], ['MN', '🇲🇳'], ['MO', '🇲🇴'], ['MP', '🇲🇵'], ['MQ', '🇲🇶'], ['MR', '🇲🇷'], ['MS', '🇲🇸'], ['MT', '🇲🇹'], ['MU', '🇲🇺'], ['MV', '🇲🇻'], ['MW', '🇲🇼'], ['MX', '🇲🇽'], ['MY', '🇲🇾'], ['MZ', '🇲🇿'], ['NA', '🇳🇦'], ['NC', '🇳🇨'], ['NE', '🇳🇪'], ['NF', '🇳🇫'], ['NG', '🇳🇬'], ['NI', '🇳🇮'], ['NL', '🇳🇱'], ['NO', '🇳🇴'], ['NP', '🇳🇵'], ['NR', '🇳🇷'], ['NZ', '🇳🇿'], ['OM', '🇴🇲'], ['PA', '🇵🇦'], ['PE', '🇵🇪'], ['PF', '🇵🇫'], ['PG', '🇵🇬'], ['PH', '🇵🇭'], ['PK', '🇵🇰'], ['PL', '🇵🇱'], ['PM', '🇵🇲'], ['PR', '🇵🇷'], ['PS', '🇵🇸'], ['PT', '🇵🇹'], ['PW', '🇵🇼'], ['PY', '🇵🇾'], ['QA', '🇶🇦'], ['RE', '🇷🇪'], ['RO', '🇷🇴'], ['RS', '🇷🇸'], ['RU', '🇷🇺'], ['RW', '🇷🇼'], ['SA', '🇸🇦'], ['SB', '🇸🇧'], ['SC', '🇸🇨'], ['SD', '🇸🇩'], ['SE', '🇸🇪'], ['SG', '🇸🇬'], ['SI', '🇸🇮'], ['SK', '🇸🇰'], ['SL', '🇸🇱'], ['SM', '🇸🇲'], ['SN', '🇸🇳'], ['SR', '🇸🇷'], ['ST', '🇸🇹'], ['SV', '🇸🇻'], ['SY', '🇸🇾'], ['SZ', '🇸🇿'], ['TC', '🇹🇨'], ['TD', '🇹🇩'], ['TG', '🇹🇬'], ['TH', '🇹🇭'], ['TJ', '🇹🇯'], ['TL', '🇹🇱'], ['TM', '🇹🇲'], ['TN', '🇹🇳'], ['TO', '🇹🇴'], ['TR', '🇹🇷'], ['TT', '🇹🇹'], ['TV', '🇹🇻'], ['TW', '🇨🇳'], ['TZ', '🇹🇿'], ['UA', '🇺🇦'], ['UG', '🇺🇬'], ['UK', '🇬🇧'], ['UM', '🇺🇲'], ['US', '🇺🇸'], ['UY', '🇺🇾'], ['UZ', '🇺🇿'], ['VA', '🇻🇦'], ['VC', '🇻🇨'], ['VE', '🇻🇪'], ['VG', '🇻🇬'], ['VI', '🇻🇮'], ['VN', '🇻🇳'], ['VU', '🇻🇺'], ['WS', '🇼🇸'], ['YE', '🇾🇪'], ['YT', '🇾🇹'], ['ZA', '🇿🇦'], ['ZM', '🇿🇲']
]

$.isPanel = () => $.isSurge() && typeof $input != 'undefined' && $.lodash_get($input, 'purpose') === 'panel'
$.isTile = () => $.isStash() && typeof $script != 'undefined' && $.lodash_get($script, 'type') === 'tile'

let arg
if (typeof $argument != 'undefined') {
	arg = Object.fromEntries($argument.split('&')
		.map(item => item.split('=')))
}

let title = 'IP信息查询'
let content = ''
!(async () => {
	if ($.isTile()) {
		await notify('IP信息查询', '面板', '开始查询')
	}
	let [info] = await Promise.all([getInfo()])
	$.log($.toStr(info))
	const ip = $.lodash_get(info, 'ip') || ' - '
	let par = [], ping
	try {
		for (let i = 0; i < 2; i++) {
			par.push(parseFloat(await http()));
		}
		if (2 === par.length) {
			ping = ': ' + Math.floor((par[0] + par[1]) / 2) + 'ms';
		} else {
			ping = ': ' + par[0] + 'ms';
		}
	} catch (i) {
		console.log(i.message);
	}
	let ipInfo = 'IP地址: ' + `${ip}${ping}\n`
	let geo = [];
	['country', 'city'].forEach(key => {
		geo.push(`${$.lodash_get(info, key) || ' - '}`)
	})
	geo = geo.length > 0 ? `${geo.join(' ')}\n` : ''
	geo = 'IP位置: ' + getIcon(geo.substring(0, 2), ICONS) + geo
	let company = [];
	['name'].forEach(key => {
		company.push(
			`企业${key === 'name' ? '' : ` ${key.toUpperCase()}`}:     ${$.lodash_get(info, `company.${key}`) || ' - '}`
		)
	})
	let asn = [];
	['name'].forEach(key => {
		asn.push(
			`ASN${key === 'name' ? '' : ` ${key.toUpperCase()}`}:     ${$.lodash_get(info, `asn.${key}`) || ' - '}`
		)
	})
	asn = asn.length > 0 ? `${asn}\n` : ''
	let type = [];
	['type'].forEach(key => {
		type.push(
			`IP类型${key === 'type' ? '' : ` ${key.toUpperCase()}`}: ${$.lodash_get(info, `asn.${key}`) || ' - '}`
		)
	})
	type = type.length > 0 ? `${type}` : 'hosting'
	let asnTs = type.substring(6)
	if ('hosting' === asnTs) {
		type = type.replace(asnTs, 'IDC机房')
	} else if ('isp' === asnTs) {
		type = type.replace(asnTs, '家庭宽带')
	} else if ('business' === asnTs) {
		type = type.replace(asnTs, '企业商务')
	}
	company = company.length > 0 ? `${company.join('\n')}\n` : ''
	let time = '\n执行时间: ' + formatLocalDate(new Date())
	content = ipInfo + `${geo}${company}${asn}${type}` + time
	if ($.isTile()) {
		await notify('IP信息查询', '面板', '查询完成')
	} else if (!$.isPanel()) {
		await notify('IP信息查询', title, content)
	}
})()
	.catch(async e => {
		$.logErr(e)
		$.logErr($.toStr(e))
		const msg = `${$.lodash_get(e, 'message') || $.lodash_get(e, 'error') || e}`
		title = `❌`
		content = msg
		await notify('IP信息查询', title, content)
	})
	.finally(async () => {
		const result = {
			title,
			content,
			icon: "globe.asia.australia",
			'icon-color': '#3D90ED'
		}
		$.log($.toStr(result))
		$.done(result)
	})

async function notify(title, subt, desc, opts) {
	if ($.lodash_get(arg, 'notify')) {
		$.msg(title, subt, desc, opts)
	} else {
		$.log('🔕', title, subt, desc, opts)
	}
}

function formatLocalDate(date) {
	return (
		date.getFullYear() + '-' +
		(date.getMonth() + 1).toString().padStart(2, '0') + '-' +
		date.getDate().toString().padStart(2, '0') + ' ' +
		date.toTimeString().split(' ')[0]
	);
}

function getIcon(code, icons) {
	if (code != null && code.length === 2) {
		for (let i = 0; i < icons.length; i++) {
			if (icons[i][0] === code) {
				return icons[i][1]
			}
		}
	}
	return ''
}

async function http() {
	return new Promise((resolve, reject) => {
		let e = Date.now();
		const timeoutPromise = new Promise((_, reject) => {
			setTimeout(() => {
				repin++;
				reject("");
				resolve("2e3");
			}, 1900);
		});
		const reqPromise = new Promise((resolve) => {
			$httpClient.get('http://www.google.com/generate_204', resolve);
		});
		Promise.race([reqPromise, timeoutPromise])
			.then((i) => {
				resolve(Date.now() - e);
			})
			.catch((error) => {
				reject(error);
				resolve("1e4");
			});
	});
}

async function getInfo() {
	let info = {}
	try {
		const res = await $.http.get({
			url: `https://ipinfo.io/widget/`,
			headers: {
				Referer: 'https://ipinfo.io/widget/',
				'User-Agent': 'Mozilla/5.0 (iPhone CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1 Edg/109.0.0.0',
			},
		})
		let body = String($.lodash_get(res, 'body'))
		try {
			body = JSON.parse(body)
		} catch (e) { }
		info = body
	} catch (e) {
		$.logErr(e)
		$.logErr($.toStr(e))
	}
	return info
}

function Env(t, s) {
	class e {
		constructor(t) {
			this.env = t
		}
		send(t, s = "GET") {
			t = "string" == typeof t ? {
				url: t
			} : t;
			let e = this.get;
			return "POST" === s && (e = this.post), new Promise((s, i) => {
				e.call(this, t, (t, e, r) => {
					t ? i(t) : s(e)
				})
			})
		}
		get(t) {
			return this.send.call(this.env, t)
		}
		post(t) {
			return this.send.call(this.env, t, "POST")
		}
	}
	return new class {
		constructor(t, s) {
			this.name = t, this.http = new e(this), this.data = null, this.dataFile = "box.dat", this.logs = [], this.isMute = !1, this.isNeedRewrite = !1, this.logSeparator = "\n", this.encoding = "utf-8", this.startTime = (new Date)
				.getTime(), Object.assign(this, s), this.log("", `\ud83d\udd14${this.name}, \u5f00\u59cb!`)
		}
		isNode() {
			return "undefined" != typeof module && !!module.exports
		}
		isQuanX() {
			return "undefined" != typeof $task
		}
		isSurge() {
			return "undefined" != typeof $environment && $environment["surge-version"]
		}
		isLoon() {
			return "undefined" != typeof $loon
		}
		isShadowrocket() {
			return "undefined" != typeof $rocket
		}
		isStash() {
			return "undefined" != typeof $environment && $environment["stash-version"]
		}
		toObj(t, s = null) {
			try {
				return JSON.parse(t)
			} catch {
				return s
			}
		}
		toStr(t, s = null) {
			try {
				return JSON.stringify(t)
			} catch {
				return s
			}
		}
		getjson(t, s) {
			let e = s;
			const i = this.getdata(t);
			if (i) try {
				e = JSON.parse(this.getdata(t))
			} catch { }
			return e
		}
		setjson(t, s) {
			try {
				return this.setdata(JSON.stringify(t), s)
			} catch {
				return !1
			}
		}
		getScript(t) {
			return new Promise(s => {
				this.get({
					url: t
				}, (t, e, i) => s(i))
			})
		}
		runScript(t, s) {
			return new Promise(e => {
				let i = this.getdata("@chavy_boxjs_userCfgs.httpapi");
				i = i ? i.replace(/\n/g, "")
					.trim() : i;
				let r = this.getdata("@chavy_boxjs_userCfgs.httpapi_timeout");
				r = r ? 1 * r : 20, r = s && s.timeout ? s.timeout : r;
				const [o, h] = i.split("@"), a = {
					url: `http://${h}/v1/scripting/evaluate`,
					body: {
						script_text: t,
						mock_type: "cron",
						timeout: r
					},
					headers: {
						"X-Key": o,
						Accept: "*/*"
					}
				};
				this.post(a, (t, s, i) => e(i))
			})
				.catch(t => this.logErr(t))
		}
		loaddata() {
			if (!this.isNode()) return {}; {
				this.fs = this.fs ? this.fs : require("fs"), this.path = this.path ? this.path : require("path");
				const t = this.path.resolve(this.dataFile),
					s = this.path.resolve(process.cwd(), this.dataFile),
					e = this.fs.existsSync(t),
					i = !e && this.fs.existsSync(s);
				if (!e && !i) return {}; {
					const i = e ? t : s;
					try {
						return JSON.parse(this.fs.readFileSync(i))
					} catch (t) {
						return {}
					}
				}
			}
		}
		writedata() {
			if (this.isNode()) {
				this.fs = this.fs ? this.fs : require("fs"), this.path = this.path ? this.path : require("path");
				const t = this.path.resolve(this.dataFile),
					s = this.path.resolve(process.cwd(), this.dataFile),
					e = this.fs.existsSync(t),
					i = !e && this.fs.existsSync(s),
					r = JSON.stringify(this.data);
				e ? this.fs.writeFileSync(t, r) : i ? this.fs.writeFileSync(s, r) : this.fs.writeFileSync(t, r)
			}
		}
		lodash_get(t, s, e) {
			const i = s.replace(/\[(\d+)\]/g, ".$1")
				.split(".");
			let r = t;
			for (const t of i)
				if (r = Object(r)[t], void 0 === r) return e;
			return r
		}
		lodash_set(t, s, e) {
			return Object(t) !== t ? t : (Array.isArray(s) || (s = s.toString()
				.match(/[^.[\]]+/g) || []), s.slice(0, -1)
					.reduce((t, e, i) => Object(t[e]) === t[e] ? t[e] : t[e] = Math.abs(s[i + 1]) >> 0 == +s[i + 1] ? [] : {}, t)[s[s.length - 1]] = e, t)
		}
		getdata(t) {
			let s = this.getval(t);
			if (/^@/.test(t)) {
				const [, e, i] = /^@(.*?)\.(.*?)$/.exec(t), r = e ? this.getval(e) : "";
				if (r) try {
					const t = JSON.parse(r);
					s = t ? this.lodash_get(t, i, "") : s
				} catch (t) {
					s = ""
				}
			}
			return s
		}
		setdata(t, s) {
			let e = !1;
			if (/^@/.test(s)) {
				const [, i, r] = /^@(.*?)\.(.*?)$/.exec(s), o = this.getval(i), h = i ? "null" === o ? null : o || "{}" : "{}";
				try {
					const s = JSON.parse(h);
					this.lodash_set(s, r, t), e = this.setval(JSON.stringify(s), i)
				} catch (s) {
					const o = {};
					this.lodash_set(o, r, t), e = this.setval(JSON.stringify(o), i)
				}
			} else e = this.setval(t, s);
			return e
		}
		getval(t) {
			return this.isSurge() || this.isShadowrocket() || this.isLoon() || this.isStash() ? $persistentStore.read(t) : this.isQuanX() ? $prefs.valueForKey(t) : this.isNode() ? (this.data = this.loaddata(), this.data[t]) : this.data && this.data[t] || null
		}
		setval(t, s) {
			return this.isSurge() || this.isShadowrocket() || this.isLoon() || this.isStash() ? $persistentStore.write(t, s) : this.isQuanX() ? $prefs.setValueForKey(t, s) : this.isNode() ? (this.data = this.loaddata(), this.data[s] = t, this.writedata(), !0) : this.data && this.data[s] || null
		}
		initGotEnv(t) {
			this.got = this.got ? this.got : require("got"), this.cktough = this.cktough ? this.cktough : require("tough-cookie"), this.ckjar = this.ckjar ? this.ckjar : new this.cktough.CookieJar, t && (t.headers = t.headers ? t.headers : {}, void 0 === t.headers.Cookie && void 0 === t.cookieJar && (t.cookieJar = this.ckjar))
		}
		get(t, s = (() => { })) {
			if (t.headers && (delete t.headers["Content-Type"], delete t.headers["Content-Length"]), this.isSurge() || this.isShadowrocket() || this.isLoon() || this.isStash()) this.isSurge() && this.isNeedRewrite && (t.headers = t.headers || {}, Object.assign(t.headers, {
				"X-Surge-Skip-Scripting": !1
			})), $httpClient.get(t, (t, e, i) => {
				!t && e && (e.body = i, e.statusCode = e.status ? e.status : e.statusCode, e.status = e.statusCode), s(t, e, i)
			});
			else if (this.isQuanX()) this.isNeedRewrite && (t.opts = t.opts || {}, Object.assign(t.opts, {
				hints: !1
			})), $task.fetch(t)
				.then(t => {
					const {
						statusCode: e,
						statusCode: i,
						headers: r,
						body: o
					} = t;
					s(null, {
						status: e,
						statusCode: i,
						headers: r,
						body: o
					}, o)
				}, t => s(t && t.error || "UndefinedError"));
			else if (this.isNode()) {
				let e = require("iconv-lite");
				this.initGotEnv(t), this.got(t)
					.on("redirect", (t, s) => {
						try {
							if (t.headers["set-cookie"]) {
								const e = t.headers["set-cookie"].map(this.cktough.Cookie.parse)
									.toString();
								e && this.ckjar.setCookieSync(e, null), s.cookieJar = this.ckjar
							}
						} catch (t) {
							this.logErr(t)
						}
					})
					.then(t => {
						const {
							statusCode: i,
							statusCode: r,
							headers: o,
							rawBody: h
						} = t, a = e.decode(h, this.encoding);
						s(null, {
							status: i,
							statusCode: r,
							headers: o,
							rawBody: h,
							body: a
						}, a)
					}, t => {
						const {
							message: i,
							response: r
						} = t;
						s(i, r, r && e.decode(r.rawBody, this.encoding))
					})
			}
		}
		post(t, s = (() => { })) {
			const e = t.method ? t.method.toLocaleLowerCase() : "post";
			if (t.body && t.headers && !t.headers["Content-Type"] && (t.headers["Content-Type"] = "application/x-www-form-urlencoded"), t.headers && delete t.headers["Content-Length"], this.isSurge() || this.isShadowrocket() || this.isLoon() || this.isStash()) this.isSurge() && this.isNeedRewrite && (t.headers = t.headers || {}, Object.assign(t.headers, {
				"X-Surge-Skip-Scripting": !1
			})), $httpClient[e](t, (t, e, i) => {
				!t && e && (e.body = i, e.statusCode = e.status ? e.status : e.statusCode, e.status = e.statusCode), s(t, e, i)
			});
			else if (this.isQuanX()) t.method = e, this.isNeedRewrite && (t.opts = t.opts || {}, Object.assign(t.opts, {
				hints: !1
			})), $task.fetch(t)
				.then(t => {
					const {
						statusCode: e,
						statusCode: i,
						headers: r,
						body: o
					} = t;
					s(null, {
						status: e,
						statusCode: i,
						headers: r,
						body: o
					}, o)
				}, t => s(t && t.error || "UndefinedError"));
			else if (this.isNode()) {
				let i = require("iconv-lite");
				this.initGotEnv(t);
				const {
					url: r,
					...o
				} = t;
				this.got[e](r, o)
					.then(t => {
						const {
							statusCode: e,
							statusCode: r,
							headers: o,
							rawBody: h
						} = t, a = i.decode(h, this.encoding);
						s(null, {
							status: e,
							statusCode: r,
							headers: o,
							rawBody: h,
							body: a
						}, a)
					}, t => {
						const {
							message: e,
							response: r
						} = t;
						s(e, r, r && i.decode(r.rawBody, this.encoding))
					})
			}
		}
		time(t, s = null) {
			const e = s ? new Date(s) : new Date;
			let i = {
				"M+": e.getMonth() + 1,
				"d+": e.getDate(),
				"H+": e.getHours(),
				"m+": e.getMinutes(),
				"s+": e.getSeconds(),
				"q+": Math.floor((e.getMonth() + 3) / 3),
				S: e.getMilliseconds()
			};
			/(y+)/.test(t) && (t = t.replace(RegExp.$1, (e.getFullYear() + "")
				.substr(4 - RegExp.$1.length)));
			for (let s in i) new RegExp("(" + s + ")")
				.test(t) && (t = t.replace(RegExp.$1, 1 == RegExp.$1.length ? i[s] : ("00" + i[s])
					.substr(("" + i[s])
						.length)));
			return t
		}
		queryStr(t) {
			let s = "";
			for (const e in t) {
				let i = t[e];
				null != i && "" !== i && ("object" == typeof i && (i = JSON.stringify(i)), s += `${e}=${i}&`)
			}
			return s = s.substring(0, s.length - 1), s
		}
		msg(s = t, e = "", i = "", r) {
			const o = t => {
				if (!t) return t;
				if ("string" == typeof t) return this.isLoon() ? t : this.isQuanX() ? {
					"open-url": t
				} : this.isSurge() || this.isShadowrocket() || this.isStash() ? {
					url: t
				} : void 0;
				if ("object" == typeof t) {
					if (this.isLoon()) {
						let s = t.openUrl || t.url || t["open-url"],
							e = t.mediaUrl || t["media-url"];
						return {
							openUrl: s,
							mediaUrl: e
						}
					}
					if (this.isQuanX()) {
						let s = t["open-url"] || t.url || t.openUrl,
							e = t["media-url"] || t.mediaUrl,
							i = t["update-pasteboard"] || t.updatePasteboard;
						return {
							"open-url": s,
							"media-url": e,
							"update-pasteboard": i
						}
					}
					if (this.isSurge() || this.isShadowrocket() || this.isStash()) {
						let s = t.url || t.openUrl || t["open-url"];
						return {
							url: s
						}
					}
				}
			};
			if (this.isMute || (this.isSurge() || this.isShadowrocket() || this.isLoon() || this.isStash() ? $notification.post(s, e, i, o(r)) : this.isQuanX() && $notify(s, e, i, o(r))), !this.isMuteLog) {
				let t = ["", "==============\ud83d\udce3\u7cfb\u7edf\u901a\u77e5\ud83d\udce3=============="];
				t.push(s), e && t.push(e), i && t.push(i), console.log(t.join("\n")), this.logs = this.logs.concat(t)
			}
		}
		log(...t) {
			t.length > 0 && (this.logs = [...this.logs, ...t]), console.log(t.join(this.logSeparator))
		}
		logErr(t, s) {
			const e = !this.isSurge() || this.isShadowrocket() && !this.isQuanX() && !this.isLoon() && !this.isStash();
			e ? this.log("", `\u2757\ufe0f${this.name}, \u9519\u8bef!`, t.stack) : this.log("", `\u2757\ufe0f${this.name}, \u9519\u8bef!`, t)
		}
		wait(t) {
			return new Promise(s => setTimeout(s, t))
		}
		done(t = {}) {
			const s = (new Date)
				.getTime(),
				e = (s - this.startTime) / 1e3;
			this.log("", `\ud83d\udd14${this.name}, \u7ed3\u675f! \ud83d\udd5b ${e} \u79d2`), this.log(), this.isSurge() || this.isShadowrocket() || this.isQuanX() || this.isLoon() || this.isStash() ? $done(t) : this.isNode() && process.exit(1)
		}
	}(t, s)
}