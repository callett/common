#!/bin/bash

# 一键安装和配置 dnsmasq 脚本

# 检查是否为root用户
if [[ $EUID -ne 0 ]]; then
   echo "此脚本必须以root用户权限运行！"
   exit 1
fi

# 更新系统并安装 dnsmasq
echo "正在安装 dnsmasq..."
apt update && apt -y install dnsmasq || { echo "dnsmasq 安装失败！"; exit 1; }

# 配置分流规则
echo "配置 dnsmasq 分流规则..."
cat > /etc/dnsmasq.conf << EOF
# Dazn
server=/control.kochava.com/157.20.104.47
server=/d151l6v8er5bdm.cloudfront.net/157.20.104.47
server=/d1sgwhnao7452x.cloudfront.net/157.20.104.47
server=/dazn-api.com/157.20.104.47
server=/dazn.com/157.20.104.47
server=/dazndn.com/157.20.104.47
server=/dc2-vodhls-perform.secure.footprint.net/157.20.104.47
server=/dca-ll-livedazn-dznlivejp.s.llnwi.net/157.20.104.47
server=/dca-ll-voddazn-dznvodjp.s.llnwi.net/157.20.104.47
server=/dcalivedazn.akamaized.net/157.20.104.47
server=/dcblivedazn.akamaized.net/157.20.104.47
server=/indazn.com/157.20.104.47
server=/indaznlab.com/157.20.104.47
server=/intercom.io/157.20.104.47
server=/logx.optimizely.com/157.20.104.47
server=/s.yimg.jp/157.20.104.47
server=/sentry.io/157.20.104.47

# Disney
server=/20thcenturystudios.com.au/157.20.104.47
server=/20thcenturystudios.com.br/157.20.104.47
server=/20thcenturystudios.jp/157.20.104.47
server=/abc-studios.com/157.20.104.47
server=/abc.com/157.20.104.47
server=/abcnews.com/157.20.104.47
server=/abcnews.edgesuite.net/157.20.104.47
server=/adobedtm.com/157.20.104.47
server=/adventuresbydisney.com/157.20.104.47
server=/babble.com/157.20.104.47
server=/babyzone.com/157.20.104.47
server=/bam.nr-data.net/157.20.104.47
server=/bamgrid.com/157.20.104.47
server=/beautyandthebeastmusical.co.uk/157.20.104.47
server=/braze.com/157.20.104.47
server=/cdn.optimizely.com/157.20.104.47
server=/conviva.com/157.20.104.47
server=/d9.flashtalking.com/157.20.104.47
server=/dilcdn.com/157.20.104.47
server=/disney-asia.com/157.20.104.47
server=/disney-discount.com/157.20.104.47
server=/disney-plus.net/157.20.104.47
server=/disney-portal.my.onetrust.com/157.20.104.47
server=/disney-studio.com/157.20.104.47
server=/disney-studio.net/157.20.104.47
server=/disney.asia/157.20.104.47
server=/disney.be/157.20.104.47
server=/disney.bg/157.20.104.47
server=/disney.ca/157.20.104.47
server=/disney.ch/157.20.104.47
server=/disney.co.il/157.20.104.47
server=/disney.co.jp/157.20.104.47
server=/disney.co.kr/157.20.104.47
server=/disney.co.th/157.20.104.47
server=/disney.co.uk/157.20.104.47
server=/disney.co.za/157.20.104.47
server=/disney.com/157.20.104.47
server=/disney.com.au/157.20.104.47
server=/disney.com.br/157.20.104.47
server=/disney.com.hk/157.20.104.47
server=/disney.com.tw/157.20.104.47
server=/disney.cz/157.20.104.47
server=/disney.de/157.20.104.47
server=/disney.demdex.net/157.20.104.47
server=/disney.dk/157.20.104.47
server=/disney.es/157.20.104.47
server=/disney.fi/157.20.104.47
server=/disney.fr/157.20.104.47
server=/disney.gr/157.20.104.47
server=/disney.hu/157.20.104.47
server=/disney.id/157.20.104.47
server=/disney.in/157.20.104.47
server=/disney.io/157.20.104.47
server=/disney.it/157.20.104.47
server=/disney.my/157.20.104.47
server=/disney.my.sentry.io/157.20.104.47
server=/disney.nl/157.20.104.47
server=/disney.no/157.20.104.47
server=/disney.ph/157.20.104.47
server=/disney.pl/157.20.104.47
server=/disney.pt/157.20.104.47
server=/disney.ro/157.20.104.47
server=/disney.ru/157.20.104.47
server=/disney.se/157.20.104.47
server=/disney.sg/157.20.104.47
server=/disneyadsales.com/157.20.104.47
server=/disneyarena.com/157.20.104.47
server=/disneyaulani.com/157.20.104.47
server=/disneybaby.com/157.20.104.47
server=/disneycareers.com/157.20.104.47
server=/disneychannelonstage.com/157.20.104.47
server=/disneychannelroadtrip.com/157.20.104.47
server=/disneycruisebrasil.com/157.20.104.47
server=/disneyenconcert.com/157.20.104.47
server=/disneyiejobs.com/157.20.104.47
server=/disneyinflight.com/157.20.104.47
server=/disneyinternational.com/157.20.104.47
server=/disneyinternationalhd.com/157.20.104.47
server=/disneyjunior.com/157.20.104.47
server=/disneyjuniortreataday.com/157.20.104.47
server=/disneylandparis.com/157.20.104.47
server=/disneylatino.com/157.20.104.47
server=/disneymagicmoments.co.il/157.20.104.47
server=/disneymagicmoments.co.uk/157.20.104.47
server=/disneymagicmoments.co.za/157.20.104.47
server=/disneymagicmoments.de/157.20.104.47
server=/disneymagicmoments.es/157.20.104.47
server=/disneymagicmoments.fr/157.20.104.47
server=/disneymagicmoments.gen.tr/157.20.104.47
server=/disneymagicmoments.gr/157.20.104.47
server=/disneymagicmoments.it/157.20.104.47
server=/disneymagicmoments.pl/157.20.104.47
server=/disneymagicmomentsme.com/157.20.104.47
server=/disneyme.com/157.20.104.47
server=/disneymeetingsandevents.com/157.20.104.47
server=/disneymovieinsiders.com/157.20.104.47
server=/disneymusicpromotion.com/157.20.104.47
server=/disneynewseries.com/157.20.104.47
server=/disneynow.com/157.20.104.47
server=/disneypeoplesurveys.com/157.20.104.47
server=/disneyplus.bn5x.net/157.20.104.47
server=/disneyplus.com/157.20.104.47
server=/disneyplus.com.ssl.sc.omtrdc.net/157.20.104.47
server=/disneyprivacycenter.com/157.20.104.47
server=/disneyredirects.com/157.20.104.47
server=/disneysrivieraresort.com/157.20.104.47
server=/disneystore.com/157.20.104.47
server=/disneystreaming.com/157.20.104.47
server=/disneysubscription.com/157.20.104.47
server=/disneytermsofuse.com/157.20.104.47
server=/disneytickets.co.uk/157.20.104.47
server=/disneyturkiye.com.tr/157.20.104.47
server=/disneytvajobs.com/157.20.104.47
server=/disneyworld-go.com/157.20.104.47
server=/dlp-media.com/157.20.104.47
server=/dmed.technology/157.20.104.47
server=/dssott.com/157.20.104.47
server=/dtci.co/157.20.104.47
server=/dtci.technology/157.20.104.47
server=/edgedatg.com/157.20.104.47
server=/espn.co.uk/157.20.104.47
server=/espn.com/157.20.104.47
server=/espn.hb.omtrdc.net/157.20.104.47
server=/espn.net/157.20.104.47
server=/espncdn.com/157.20.104.47
server=/espndotcom.tt.omtrdc.net/157.20.104.47
server=/espnqa.com/157.20.104.47
server=/execute-api.us-east-1.amazonaws.com/157.20.104.47
server=/go-disneyworldgo.com/157.20.104.47
server=/go.com/157.20.104.47
server=/hotstar-cdn.net/157.20.104.47
server=/hotstar-labs.com/157.20.104.47
server=/hotstar.com/157.20.104.47
server=/hotstarext.com/157.20.104.47
server=/hsprepack.akamaized.net/157.20.104.47
server=/js-agent.newrelic.com/157.20.104.47
server=/marvel.com/157.20.104.47
server=/marvel10thanniversary.com/157.20.104.47
server=/marveldimensionofheroes.com/157.20.104.47
server=/marvelparty.net/157.20.104.47
server=/marvelpinball.com/157.20.104.47
server=/marvelsdoubleagent.com/157.20.104.47
server=/marvelspotlightplays.com/157.20.104.47
server=/marvelsuperheroseptember.com/157.20.104.47
server=/marvelsuperwar.com/157.20.104.47
server=/mickey.tv/157.20.104.47
server=/moviesanywhere.com/157.20.104.47
server=/natgeomaps.com/157.20.104.47
server=/nationalgeographic.com/157.20.104.47
server=/nationalgeographicpartners.com/157.20.104.47
server=/ngeo.com/157.20.104.47
server=/nomadlandmovie.ch/157.20.104.47
server=/playmation.com/157.20.104.47
server=/shopdisney.com/157.20.104.47
server=/shops-disney.com/157.20.104.47
server=/sorcerersarena.com/157.20.104.47
server=/spaindisney.com/157.20.104.47
server=/star-brasil.com/157.20.104.47
server=/star-latam.com/157.20.104.47
server=/starott.com/157.20.104.47
server=/starplus.com/157.20.104.47
server=/starwars.com/157.20.104.47
server=/starwarsgalacticstarcruiser.com/157.20.104.47
server=/starwarskids.com/157.20.104.47
server=/streamingdisney.net/157.20.104.47
server=/themarvelexperiencetour.com/157.20.104.47
server=/thestationbymaker.com/157.20.104.47
server=/thewaltdisneycompany.com/157.20.104.47
server=/thisispolaris.com/157.20.104.47
server=/watchdisneyfe.com/157.20.104.47
server=/watchespn.com/157.20.104.47

# Netflix
server=/e13252.dscg.akamaiedge.net/157.20.104.47
server=/h-netflix.online-metrix.net/157.20.104.47
server=/netflix.com.edgesuite.net/157.20.104.47
server=/cookielaw.org/157.20.104.47
server=/fast.com/157.20.104.47
server=/flxvpn.net/157.20.104.47
server=/netflix.ca/157.20.104.47
server=/netflix.com/157.20.104.47
server=/netflix.com.au/157.20.104.47
server=/netflix.com.edgesuite.net/157.20.104.47
server=/netflix.net/157.20.104.47
server=/netflixdnstest0.com/157.20.104.47
server=/netflixdnstest1.com/157.20.104.47
server=/netflixdnstest10.com/157.20.104.47
server=/netflixdnstest2.com/157.20.104.47
server=/netflixdnstest3.com/157.20.104.47
server=/netflixdnstest4.com/157.20.104.47
server=/netflixdnstest5.com/157.20.104.47
server=/netflixdnstest6.com/157.20.104.47
server=/netflixdnstest7.com/157.20.104.47
server=/netflixdnstest8.com/157.20.104.47
server=/netflixdnstest9.com/157.20.104.47
server=/netflixinvestor.com/157.20.104.47
server=/netflixstudios.com/157.20.104.47
server=/netflixtechblog.com/157.20.104.47
server=/nflxext.com/157.20.104.47
server=/nflximg.com/157.20.104.47
server=/nflximg.net/157.20.104.47
server=/nflxsearch.net/157.20.104.47
server=/nflxso.net/157.20.104.47
server=/nflxvideo.net/157.20.104.47
server=/onetrust.com/157.20.104.47
server=/us-west-2.amazonaws.com/157.20.104.47

# OpenAI
server=/browser-intake-datadoghq.com/157.20.104.47
server=/chat.openai.com.cdn.cloudflare.net/157.20.104.47
server=/gemini.google.com/157.20.104.47
server=/openai-api.arkoselabs.com/157.20.104.47
server=/openaicom-api-bdcpf8c6d2e9atf6.z01.azurefd.net/157.20.104.47
server=/openaicomproductionae4b.blob.core.windows.net/157.20.104.47
server=/production-openaicom-storage.azureedge.net/157.20.104.47
server=/static.cloudflareinsights.com/157.20.104.47
server=/ai.com/157.20.104.47
server=/algolia.net/157.20.104.47
server=/api.statsig.com/157.20.104.47
server=/auth0.com/157.20.104.47
server=/chatgpt.com/157.20.104.47
server=/chatgpt.livekit.cloud/157.20.104.47
server=/client-api.arkoselabs.com/157.20.104.47
server=/events.statsigapi.net/157.20.104.47
server=/featuregates.org/157.20.104.47
server=/host.livekit.cloud/157.20.104.47
server=/identrust.com/157.20.104.47
server=/intercom.io/157.20.104.47
server=/intercomcdn.com/157.20.104.47
server=/launchdarkly.com/157.20.104.47
server=/oaistatic.com/157.20.104.47
server=/oaiusercontent.com/157.20.104.47
server=/observeit.net/157.20.104.47
server=/openai.com/157.20.104.47
server=/openaiapi-site.azureedge.net/157.20.104.47
server=/openaicom.imgix.net/157.20.104.47
server=/segment.io/157.20.104.47
server=/sentry.io/157.20.104.47
server=/stripe.com/157.20.104.47
server=/turn.livekit.cloud/157.20.104.47
EOF

# 配置公共 DNS
echo "配置公共 DNS..."
cat > /etc/resolv.dnsmasq.conf << EOF
nameserver 1.1.1.1
nameserver 8.8.8.8
EOF

# 设置 dnsmasq 为系统 DNS
echo "配置系统 DNS..."
#chattr -i /etc/resolv.conf
echo -e "nameserver 127.0.0.1" > /etc/resolv.conf
#chattr +i /etc/resolv.conf

# 重启 dnsmasq
echo "重启 dnsmasq 服务..."
/etc/init.d/dnsmasq restart || { echo "dnsmasq 服务启动失败！"; exit 1; }

echo "dnsmasq 配置完成！"