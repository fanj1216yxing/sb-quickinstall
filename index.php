<?php
/* ===================== 配置：在这里增删链接 ===================== */
$links = [
  ['name' => 'zouter(香港）', 'url' => 'http://167.148.203.60:2333'],
  ['name' => '云悠香港', 'url' => 'http://154.36.165.138:2333'],
  ['name' => 'renet 1', 'url' => 'http://202.155.123.76:2333'],
  ['name' => 'zoro美',  'url' => 'http://64.81.117.24:2333'],
  ['name' => 'zoro港',  'url' => 'http://61.15.107.155:2333'],
  ['name' => 'zoro美2', 'url' => 'https://st.2519775.xyz'],
  ['name' => '回家', 'url' => 'https://home.2519775.xyz'],
  ['name' => '威亚云',  'url' => 'http://154.9.237.150:2333'],
  ['name' => 'nc 9.5o',  'url' => 'http://5.181.48.249:2333'],
  ['name' => 'nc 1', 'url' => 'http://213.109.162.36:2333'],
  ['name' => 'nc 2', 'url' => 'http://152.53.191.150:2333'],
  ['name' => 'velov',  'url' => 'http://204.197.163.244:2333'],
  ['name' => '大妈', 'url' => 'http://154.17.20.178:2333'],
  ['name' => 'nc 2', 'url' => 'http://152.53.191.150:2333'],
];
$timeoutMs = 5000;

/* ===== 安全：仅允许测本清单中的 URL（避免把接口当成通用代理） ===== */
$allow = array_column($links, 'url');

/* ===================== 后端测速 API（同文件） ===================== */
if (isset($_GET['ping'])) {
  header('Content-Type: application/json; charset=utf-8');

  $raw = $_GET['url'] ?? '';
  if (!in_array($raw, $allow, true)) {
    http_response_code(403);
    echo json_encode(['error' => 'forbidden']);
    exit;
  }
  if (!preg_match('#^https?://#i', $raw)) {
    http_response_code(400);
    echo json_encode(['error' => 'bad url']);
    exit;
  }

  // 选用 favicon 作为轻量探测目标
  $origin = preg_replace('#^(https?://[^/]+).*$#', '$1', $raw);
  $test = $origin . '/favicon.ico?__ping__=' . bin2hex(random_bytes(6));

  if (!function_exists('curl_init')) {
    // 退化方案：只做 TCP 连接耗时（fsockopen），不发 HTTP 请求
    $parts = parse_url($origin);
    $host = $parts['host'] ?? '';
    $port = ($parts['scheme'] ?? 'http') === 'https' ? 443 : 80;
    $start = microtime(true);
    $errno = $errstr = null;
    $ctx = stream_context_create([
      'ssl' => ['verify_peer' => false, 'verify_peer_name' => false]
    ]);
    $fp = @stream_socket_client(($port==443?'ssl://':'').$host.":$port", $errno, $errstr, $timeoutMs/1000, STREAM_CLIENT_CONNECT, $ctx);
    $elapsed = (int) round((microtime(true) - $start) * 1000);
    if ($fp) { fclose($fp); echo json_encode(['status'=>'load','elapsed'=>$elapsed]); }
    else { echo json_encode(['status'=>'timeout','elapsed'=>$timeoutMs]); }
    exit;
  }

  $ch = curl_init($test);
  curl_setopt_array($ch, [
    CURLOPT_NOBODY            => true,        // 只取头，足够判断通不通
    CURLOPT_FOLLOWLOCATION    => true,
    CURLOPT_CONNECTTIMEOUT_MS => $timeoutMs,
    CURLOPT_TIMEOUT_MS        => $timeoutMs,
    CURLOPT_RETURNTRANSFER    => true,
    CURLOPT_USERAGENT         => 'PingCard/1.0',
    // 为了兼容自签/过期证书的测试场景（如内网或临时证书）
    CURLOPT_SSL_VERIFYPEER    => false,
    CURLOPT_SSL_VERIFYHOST    => 2,
    CURLOPT_HTTPHEADER        => ['Accept: image/*;q=0.9,*/*;q=0.1'],
  ]);
  $start = microtime(true);
  curl_exec($ch);
  $errno = curl_errno($ch);
  curl_close($ch);
  $elapsed = (int) round((microtime(true) - $start) * 1000);

  $status = ($errno === 0) ? 'load' : (in_array($errno, [CURLE_OPERATION_TIMEDOUT, CURLE_COULDNT_CONNECT], true) ? 'timeout' : 'error');
  echo json_encode(['status' => $status, 'elapsed' => $elapsed]);
  exit;
}
?>
<!doctype html>
<html lang="zh-CN">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1" />
<title>♥</title>
<meta name="color-scheme" content="light">
<link rel="preconnect" href="https://fonts.loli.net">
<link href="https://fonts.loli.net/css2?family=ZCOOL+KuaiLe&family=Ma+Shan+Zheng&display=swap" rel="stylesheet">
<style>
  :root{
    --bg1:#ffeaf2; --bg2:#ffd6e6;
    --glass:rgba(255,255,255,.35); --glass-strong:rgba(255,255,255,.6);
    --border:rgba(255,255,255,.55); --shadow:0 10px 30px rgba(255,105,180,.18);
    --text:#d63384; --muted:#be6b97;
    --good:#2e7d32; --ok:#e65100; --slow:#c62828; --dead:#6b7280;
    --chip-bg:rgba(255,255,255,.65);
  }
  *{box-sizing:border-box} html,body{height:100%}
  body{
    margin:0;
    font:16px/1.6 "ZCOOL KuaiLe","Ma Shan Zheng","ZCOOL XiaoWei","LXGW WenKai","PingFang SC","Hiragino Sans GB","Microsoft YaHei",system-ui,-apple-system,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif;
    color:var(--text);
    background:
      radial-gradient(1200px 800px at 10% 10%, var(--bg2), transparent 60%),
      radial-gradient(900px 700px at 90% 30%, #ffd0df, transparent 60%),
      linear-gradient(180deg, var(--bg1), #fff 60%);
    display:grid;place-items:center;padding:24px;
  }
  .wrap{width:min(980px,100%);background:var(--glass);border:1px solid var(--border);
    backdrop-filter: blur(14px) saturate(120%);-webkit-backdrop-filter: blur(14px) saturate(120%);
    border-radius:24px;box-shadow:var(--shadow);overflow:hidden;}
  header{padding:28px 28px 12px;display:flex;align-items:center;justify-content:space-between;gap:12px;
    background:linear-gradient(180deg, var(--glass-strong), transparent);}
  h1{margin:0;font-family:"ZCOOL KuaiLe","Ma Shan Zheng",inherit;font-size:clamp(30px,5vw,44px);letter-spacing:2px;font-weight:800;text-shadow:0 2px 0 rgba(255,255,255,.6);}
  .actions{display:flex;gap:10px;align-items:center}
  button{border:1px solid var(--border);background:var(--chip-bg);padding:8px 14px;border-radius:999px;cursor:pointer;font-weight:700;color:var(--text);
    transition:transform .08s ease, box-shadow .2s ease, background .2s ease;box-shadow:0 6px 16px rgba(0,0,0,.05);}
  button:hover{transform:translateY(-1px)} button:active{transform:translateY(0) scale(.98)}
  .ts{font-size:12px;color:var(--muted)} main{padding:10px 18px 22px}
  .grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(260px,1fr));gap:14px;}
  .card{display:flex;align-items:center;gap:12px;padding:14px 14px;background:linear-gradient(180deg, rgba(255,255,255,.68), rgba(255,255,255,.45));
    border:1px solid var(--border);border-radius:16px;backdrop-filter: blur(8px);-webkit-backdrop-filter: blur(8px);min-height:64px;}
  .dot{width:10px;height:10px;border-radius:50%;box-shadow:0 0 0 3px rgba(255,255,255,.7) inset, 0 0 10px rgba(0,0,0,.06);flex:0 0 auto;}
  .meta{flex:1 1 auto;min-width:0}
  .meta a{color:var(--text);text-decoration:none;font-weight:800;display:inline-flex;align-items:center;gap:8px;word-break:break-all;}
  .meta small{display:none !important;} /* 按需求隐藏网址 */
  .chip{flex:0 0 auto;font-weight:800;font-size:13px;padding:6px 10px;border-radius:999px;background:var(--chip-bg);border:1px solid var(--border);
    min-width:88px;text-align:center;white-space:nowrap;color:var(--text);}
  .chip.muted{color:var(--dead)} .chip.good{color:var(--good)} .chip.ok{color:var(--ok)} .chip.slow{color:var(--slow)} .chip.dead{color:var(--dead)}
  .row{display:flex;align-items:center;justify-content:space-between;gap:10px;}
  footer{padding:10px 18px 22px;color:var(--muted);font-size:12px;text-align:center;}
  @media (prefers-reduced-motion:no-preference){.card{transition:transform .18s ease}.card:hover{transform:translateY(-2px)}}
  noscript{display:block;color:#b00020;text-align:center;padding:8px 0;font-weight:700}
</style>
</head>
<body>
  <div class="wrap" id="app">
    <header>
      <h1>欢迎回家</h1>
      <div class="actions">
        <button id="refreshBtn" title="重新测试全部链接">↻ 重新测试</button>
        <div class="ts" id="stamp">—</div>
      </div>
    </header>

    <main>
      <noscript>需要启用 JavaScript 才能显示链接与延迟</noscript>
      <div class="grid" id="list"></div>
    </main>

    <footer>
      说明：延迟为通过服务器端请求各站点 <code>favicon.ico</code> 的耗时粗略估算；默认超时 <?php echo (int)$timeoutMs; ?> ms。
    </footer>
  </div>

<script>
  const LINKS = <?php echo json_encode($links, JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES); ?>;
  const THRESHOLDS = { good: 300, ok: 800 };

  const elList = document.getElementById('list');
  const elStamp = document.getElementById('stamp');
  const elBtn = document.getElementById('refreshBtn');

  function createCard(item, idx) {
    const card = document.createElement('div'); card.className = 'card'; card.id = 'card-' + idx;
    const dot = document.createElement('div'); dot.className = 'dot'; dot.style.background = 'linear-gradient(180deg,#bbb,#ddd)'; dot.id = 'dot-' + idx;
    const meta = document.createElement('div'); meta.className = 'meta';
    const a = document.createElement('a'); a.href = item.url; a.target = '_blank'; a.rel = 'noopener noreferrer'; a.textContent = item.name;
    const small = document.createElement('small'); small.textContent = item.url; // 已隐藏
    meta.appendChild(a); meta.appendChild(small);
    const chip = document.createElement('div'); chip.className = 'chip muted'; chip.id = 'chip-' + idx; chip.textContent = '测试中…';
    const row = document.createElement('div'); row.className = 'row'; row.appendChild(meta); row.appendChild(chip);
    card.appendChild(dot); card.appendChild(row);
    return card;
  }

  function renderList() {
    elList.innerHTML = '';
    LINKS.forEach((item, i) => elList.appendChild(createCard(item, i)));
  }

  function setStatus(i, { status, elapsed }) {
    const chip = document.getElementById('chip-' + i);
    const dot  = document.getElementById('dot-' + i);

    const setDot = (color) => {
      dot.style.background = color;
      dot.style.boxShadow = '0 0 0 3px rgba(255,255,255,.7) inset, 0 0 12px rgba(0,0,0,.18)';
    };

    if (status === 'timeout') {
      chip.className = 'chip dead'; chip.textContent = '超时'; setDot('#9aa0a6'); return;
    }
    chip.className = 'chip';
    if (elapsed <= THRESHOLDS.good) { chip.classList.add('good'); setDot('#2e7d32'); }
    else if (elapsed <= THRESHOLDS.ok){ chip.classList.add('ok'); setDot('#e65100'); }
    else { chip.classList.add('slow'); setDot('#c62828'); }
    chip.textContent = elapsed + ' ms';
  }

  async function testAll() {
    elStamp.textContent = '测试时间：' + new Date().toLocaleString();
    await Promise.all(LINKS.map(async (item, i) => {
      try {
        const r = await fetch(`?ping=1&url=${encodeURIComponent(item.url)}`, {cache:'no-store'});
        const data = await r.json();
        setStatus(i, data);
      } catch(e) {
        setStatus(i, { status:'timeout', elapsed: 0 });
      }
    }));
  }

  renderList();
  (window.requestIdleCallback || function (fn){ setTimeout(fn, 300); })(testAll);
  elBtn.addEventListener('click', () => testAll());
</script>
</body>
</html>
