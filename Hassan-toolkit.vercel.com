<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HASSAN TOOLS</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --bg-color: #0b0f19;
            --text-color: #ffffff;
            --card-bg: rgba(255, 255, 255, 0.03);
            --card-border: rgba(255, 255, 255, 0.08);
            --subtext-color: #888;
            --search-bg: rgba(255, 255, 255, 0.05);
        }

        .light-mode {
            --bg-color: #f4f6f9;
            --text-color: #111111;
            --card-bg: rgba(0, 0, 0, 0.03);
            --card-border: rgba(0, 0, 0, 0.08);
            --subtext-color: #555;
            --search-bg: rgba(0, 0, 0, 0.05);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            transition: background 0.3s, color 0.3s;
        }

        body {
            background-color: var(--bg-color);
            color: var(--text-color);
            min-height: 100vh;
            overflow-x: hidden;
        }

        .ambient-glow {
            position: fixed;
            top: 20%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 300px;
            height: 300px;
            background: linear-gradient(135deg, rgba(255, 123, 0, 0.25), rgba(255, 255, 255, 0.15));
            filter: blur(120px);
            border-radius: 50%;
            pointer-events: none;
            z-index: 0;
        }

        #intro-screen {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: var(--bg-color);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            transition: opacity 0.8s ease, visibility 0.8s;
        }

        .logo-ring-container {
            position: relative;
            width: 180px;
            height: 180px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .spinner-ring {
            position: absolute;
            width: 100%;
            height: 100%;
            border-radius: 50%;
            border: 3px solid transparent;
            border-top-color: #ff7b00;
            border-bottom-color: #ffffff;
            animation: spin 2s linear infinite;
        }

        .spinner-ring-outer {
            position: absolute;
            width: 120%;
            height: 120%;
            border-radius: 50%;
            border: 2px dashed rgba(255, 123, 0, 0.5);
            animation: spin-reverse 3s linear infinite;
        }

        .logo-img {
            width: 110px;
            height: 110px;
            border-radius: 50%;
            object-fit: cover;
            z-index: 2;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        @keyframes spin-reverse {
            0% { transform: rotate(360deg); }
            100% { transform: rotate(0deg); }
        }

        .intro-title {
            margin-top: 25px;
            font-size: 24px;
            font-weight: bold;
            letter-spacing: 2px;
        }

        .intro-sub {
            color: #ff7b00;
            font-size: 12px;
            letter-spacing: 1.5px;
            margin-top: 5px;
        }

        .container {
            position: relative;
            z-index: 1;
            max-width: 480px;
            margin: 0 auto;
            padding: 20px 15px 80px 15px;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0 20px 0;
        }

        .header-brand {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .header-logo {
            width: 40px;
            height: 40px;
            border-radius: 50%;
        }

        .header-title {
            font-size: 20px;
            font-weight: bold;
        }

        .header-icons {
            display: flex;
            gap: 15px;
            font-size: 18px;
            cursor: pointer;
            color: var(--subtext-color);
        }

        .hero-section {
            text-align: center;
            margin: 20px 0;
        }

        .hero-logo-box {
            margin: 0 auto;
            width: 140px;
            height: 140px;
        }

        .main-title {
            font-size: 26px;
            font-weight: bold;
            margin-top: 15px;
            letter-spacing: 1px;
        }

        .main-subtitle {
            color: #ff7b00;
            font-size: 12px;
            letter-spacing: 2px;
            margin-top: 5px;
            font-weight: 600;
        }

        .search-box {
            background: var(--search-bg);
            border: 1px solid var(--card-border);
            border-radius: 12px;
            padding: 12px 15px;
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 25px 0;
            color: var(--subtext-color);
        }

        .search-box input {
            background: transparent;
            border: none;
            outline: none;
            color: var(--text-color);
            width: 100%;
        }

        .tool-card {
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 18px;
            overflow: hidden;
            position: relative;
            margin-bottom: 30px;
            backdrop-filter: blur(10px);
        }

        .tool-banner {
            position: relative;
            height: 180px;
            background: rgba(0,0,0,0.1);
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
        }

        .tool-banner-bg {
            position: absolute;
            width: 120px;
            height: 120px;
            background: radial-gradient(circle, rgba(255,123,0,0.4) 0%, rgba(255,255,255,0.2) 100%);
            filter: blur(25px);
            border-radius: 50%;
        }

        .tool-banner img {
            width: 110px;
            height: 110px;
            border-radius: 50%;
            z-index: 1;
            object-fit: cover;
        }

        .star-icon {
            position: absolute;
            top: 15px;
            right: 15px;
            font-size: 18px;
            color: var(--subtext-color);
            z-index: 2;
        }

        .tool-content {
            padding: 18px;
        }

        .tool-header-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 6px;
        }

        .tool-title {
            font-size: 18px;
            font-weight: bold;
        }

        .badge-vip {
            background: #00e6a8;
            color: #000;
            font-size: 10px;
            font-weight: bold;
            padding: 3px 8px;
            border-radius: 10px;
        }

        .tool-desc {
            color: var(--subtext-color);
            font-size: 13px;
            margin-bottom: 15px;
        }

        .btn-launch {
            width: 100%;
            background: linear-gradient(90deg, #ff416c, #ff4b2b);
            border: none;
            color: white;
            padding: 12px;
            border-radius: 25px;
            font-weight: bold;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            font-size: 14px;
        }

        .connect-section {
            margin-top: 35px;
        }

        .section-title {
            text-align: center;
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .connect-grid {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .connect-card {
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 14px;
            padding: 14px 16px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            text-decoration: none;
            color: var(--text-color);
        }

        .connect-left {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .connect-icon {
            width: 42px;
            height: 42px;
            border-radius: 12px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 20px;
            color: white;
        }

        .icon-tg { background: #229ED9; }
        .icon-wa { background: #25D366; }
        .icon-help { background: #ff4757; }
        .icon-support { background: #70a1ff; }

        .connect-info h4 { font-size: 15px; margin-bottom: 2px; }
        .connect-info p { font-size: 11px; color: var(--subtext-color); letter-spacing: 1px; }

        /* Notifications Modal / Popup */
        .notif-modal {
            display: none;
            position: fixed;
            top: 70px;
            right: 15px;
            width: 320px;
            background: var(--bg-color);
            border: 1px solid var(--card-border);
            border-radius: 14px;
            z-index: 10001;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
            padding: 15px;
        }

        .notif-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-weight: bold;
            margin-bottom: 12px;
            border-bottom: 1px solid var(--card-border);
            padding-bottom: 8px;
        }

        .notif-item {
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            padding: 10px;
            border-radius: 8px;
            font-size: 12px;
            margin-bottom: 8px;
        }

        .notif-item span {
            display: block;
            font-size: 10px;
            color: #ff7b00;
            margin-top: 4px;
        }

        /* Tool Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--bg-color);
            z-index: 10000;
            overflow-y: auto;
            padding: 20px 15px;
        }

        .modal-header {
            background: var(--card-bg);
            padding: 15px;
            border-radius: 12px;
            text-align: center;
            position: relative;
            margin-bottom: 15px;
            border: 1px solid var(--card-border);
        }

        .modal-close {
            position: absolute;
            right: 15px;
            top: 15px;
            font-size: 20px;
            cursor: pointer;
            color: #ff4757;
        }

        .dev-num {
            color: #25D366;
            font-size: 13px;
            margin-top: 5px;
        }

        .tab-buttons {
            display: flex;
            background: var(--card-bg);
            border-radius: 12px;
            padding: 4px;
            margin-bottom: 15px;
            border: 1px solid var(--card-border);
        }

        .tab-btn {
            flex: 1;
            padding: 10px;
            border: none;
            background: transparent;
            color: var(--subtext-color);
            font-weight: bold;
            border-radius: 10px;
            cursor: pointer;
        }

        .tab-btn.active {
            background: var(--card-border);
            color: var(--text-color);
        }

        .form-box {
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            padding: 15px;
            border-radius: 12px;
            margin-bottom: 15px;
        }

        .input-field {
            width: 100%;
            padding: 12px;
            background: rgba(0,0,0,0.2);
            border: 1px solid var(--card-border);
            border-radius: 8px;
            color: var(--text-color);
            margin-bottom: 10px;
            outline: none;
        }

        .btn-action {
            width: 100%;
            padding: 12px;
            background: #25D366;
            border: none;
            color: white;
            font-weight: bold;
            border-radius: 8px;
            cursor: pointer;
        }

        .result-box {
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 12px;
            padding: 15px;
            display: none;
        }

        .profile-img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            margin: 0 auto 10px auto;
            display: block;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            margin-top: 15px;
        }

        .stat-card {
            background: rgba(0,0,0,0.1);
            padding: 10px;
            border-radius: 8px;
            text-align: center;
            border: 1px solid var(--card-border);
        }

        .stat-card h3 { font-size: 16px; color: var(--text-color); }
        .stat-card p { font-size: 10px; color: var(--subtext-color); }

        .repo-item {
            background: rgba(0,0,0,0.1);
            padding: 8px 12px;
            border-radius: 6px;
            margin-top: 6px;
            font-size: 12px;
            word-break: break-all;
            border: 1px solid var(--card-border);
        }
    </style>
</head>
<body>

    <div class="ambient-glow"></div>

    <!-- Intro Loading Screen -->
    <div id="intro-screen">
        <div class="logo-ring-container">
            <div class="spinner-ring"></div>
            <div class="spinner-ring-outer"></div>
            <img src="https://i.postimg.cc/nLx4FJKr/1000005452.png" class="logo-img" alt="Logo">
        </div>
        <div class="intro-title">HASSAN TOOLS</div>
        <div class="intro-sub">PRO TOOLS FOR DEVELOPERS</div>
    </div>

    <!-- Main Dashboard UI -->
    <div class="container">
        <header>
            <div class="header-brand">
                <img src="https://i.postimg.cc/nLx4FJKr/1000005452.png" class="header-logo" alt="Logo">
                <div class="header-title">HASSAN TOOLS</div>
            </div>
            <div class="header-icons">
                <i id="theme-toggle" class="fa-regular fa-moon" onclick="toggleTheme()" title="Toggle Day/Night Mode"></i>
                <i class="fa-regular fa-bell" onclick="toggleNotifications()" title="Updates & Notifications"></i>
            </div>
        </header>

        <!-- Notifications Dropdown Box -->
        <div id="notif-dropdown" class="notif-modal">
            <div class="notif-header">
                <span>Updates & Notifications</span>
                <i class="fa-solid fa-xmark" style="cursor:pointer;" onclick="toggleNotifications()"></i>
            </div>
            <div id="notif-list">
                <!-- Notifications dynamically loaded here with 24-hr auto-expiry -->
            </div>
        </div>

        <div class="hero-section">
            <div class="logo-ring-container hero-logo-box">
                <div class="spinner-ring"></div>
                <div class="spinner-ring-outer"></div>
                <img src="https://i.postimg.cc/nLx4FJKr/1000005452.png" class="logo-img" alt="Logo">
            </div>
            <div class="main-title">HASSAN TOOLS</div>
            <div class="main-subtitle">PRO TOOLS FOR DEVELOPERS</div>
        </div>

        <div class="search-box">
            <i class="fa-solid fa-magnifying-glass"></i>
            <input type="text" placeholder="Search tools...">
        </div>

        <!-- Tool Card -->
        <div class="tool-card">
            <div class="tool-banner">
                <div class="tool-banner-bg"></div>
                <i class="fa-regular fa-star star-icon"></i>
                <img src="https://i.postimg.cc/nLx4FJKr/1000005452.png" alt="Tool Logo">
            </div>
            <div class="tool-content">
                <div class="tool-header-row">
                    <div class="tool-title">GIT & YT INFO</div>
                    <span class="badge-vip">VIP</span>
                </div>
                <div class="tool-desc">Github & YouTube info</div>
                <button class="btn-launch" onclick="openToolModal()">
                    <i class="fa-solid fa-rocket"></i> Launch
                </button>
            </div>
        </div>

        <!-- Social Connects -->
        <div class="connect-section">
            <div class="section-title">Connect With Us</div>
            <div class="connect-grid">
                <a href="https://t.me/hassan1updates" target="_blank" class="connect-card">
                    <div class="connect-left">
                        <div class="connect-icon icon-tg"><i class="fa-brands fa-telegram"></i></div>
                        <div class="connect-info">
                            <h4>Telegram</h4>
                            <p>JOIN CHANNEL</p>
                        </div>
                    </div>
                    <i class="fa-solid fa-arrow-up-right-from-square" style="color: var(--subtext-color);"></i>
                </a>

                <a href="https://whatsapp.com/channel/0029VbDRJh789ine9bjCVF3m" target="_blank" class="connect-card">
                    <div class="connect-left">
                        <div class="connect-icon icon-wa"><i class="fa-brands fa-whatsapp"></i></div>
                        <div class="connect-info">
                            <h4>WhatsApp</h4>
                            <p>JOIN CHANNEL</p>
                        </div>
                    </div>
                    <i class="fa-solid fa-arrow-up-right-from-square" style="color: var(--subtext-color);"></i>
                </a>

                <a href="https://wa.me/+923372938160" target="_blank" class="connect-card">
                    <div class="connect-left">
                        <div class="connect-icon icon-help"><i class="fa-regular fa-circle-question"></i></div>
                        <div class="connect-info">
                            <h4>Help</h4>
                            <p>CONTACT HELP</p>
                        </div>
                    </div>
                    <i class="fa-solid fa-arrow-up-right-from-square" style="color: var(--subtext-color);"></i>
                </a>

                <a href="https://wa.me/+923372938160" target="_blank" class="connect-card">
                    <div class="connect-left">
                        <div class="connect-icon icon-support"><i class="fa-solid fa-headset"></i></div>
                        <div class="connect-info">
                            <h4>Support</h4>
                            <p>CHAT ON WHATSAPP</p>
                        </div>
                    </div>
                    <i class="fa-solid fa-arrow-up-right-from-square" style="color: var(--subtext-color);"></i>
                </a>
            </div>
        </div>
    </div>

    <!-- Tool Screen (GitHub & YouTube) -->
    <div id="tool-modal" class="modal">
        <div class="modal-header">
            <span class="modal-close" onclick="closeToolModal()">&times;</span>
            <div style="font-weight: bold; font-size: 18px;">HASSAN <span style="color:#ff4757;">TOOLS</span></div>
            <div class="dev-num"><i class="fa-brands fa-whatsapp"></i> Dev: +92337 2938 160</div>
        </div>

        <div class="tab-buttons">
            <button id="tab-git-btn" class="tab-btn active" onclick="switchTab('git')"><i class="fa-brands fa-github"></i> GitHub Analyzer</button>
            <button id="tab-yt-btn" class="tab-btn" onclick="switchTab('yt')"><i class="fa-brands fa-youtube"></i> YT Info Fetcher</button>
        </div>

        <!-- GitHub Section -->
        <div id="git-tab-content">
            <div class="form-box">
                <input type="text" id="github-user" class="input-field" placeholder="GitHub Username (e.g. hassan-ff-max)">
                <input type="text" id="github-token" class="input-field" placeholder="Personal Access Token (Optional)">
                <button class="btn-action" onclick="fetchGitHubData()"><i class="fa-solid fa-magnifying-glass"></i> Analyze</button>
            </div>
            <div id="git-loader" style="display:none; text-align:center; padding: 15px; color:#ff7b00;">
                <i class="fa-solid fa-spinner fa-spin"></i> CRUNCHING GITHUB DATA...
            </div>
            <div id="git-results" class="result-box"></div>
        </div>

        <!-- YouTube Section -->
        <div id="yt-tab-content" style="display:none;">
            <div class="form-box">
                <input type="text" id="yt-link" class="input-field" placeholder="Paste YouTube Video Link...">
                <button class="btn-action" style="background:#ff4757;" onclick="fetchYTData()"><i class="fa-solid fa-magnifying-glass"></i> Fetch Info</button>
            </div>
            <div id="yt-results" class="result-box"></div>
        </div>
    </div>

    <script>
        // Intro Screen Timer
        window.addEventListener('load', () => {
            setTimeout(() => {
                const intro = document.getElementById('intro-screen');
                intro.style.opacity = '0';
                intro.style.visibility = 'hidden';
            }, 2500);
            loadNotifications();
        });

        // Day/Night Theme Toggle
        function toggleTheme() {
            document.body.classList.toggle('light-mode');
            const themeIcon = document.getElementById('theme-toggle');
            if(document.body.classList.contains('light-mode')) {
                themeIcon.classList.remove('fa-moon');
                themeIcon.classList.add('fa-sun');
            } else {
                themeIcon.classList.remove('fa-sun');
                themeIcon.classList.add('fa-moon');
            }
        }

        // Notification System with 24-Hour Auto Expiry
        function toggleNotifications() {
            const dropdown = document.getElementById('notif-dropdown');
            dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
        }

        function loadNotifications() {
            let updates = JSON.parse(localStorage.getItem('hassan_updates')) || [
                { title: "🚀 Git & YT Info Tool Added!", time: Date.now() - 3600000 }, // 1 hour ago
                { title: "⚡ HASSAN TOOLS v1.0 Live Released", time: Date.now() - 7200000 } // 2 hours ago
            ];

            // Filter out notifications older than 24 hours (86400000 ms)
            const currentTime = Date.now();
            updates = updates.filter(item => (currentTime - item.time) < 86400000);

            // Save filtered updates back
            localStorage.setItem('hassan_updates', JSON.stringify(updates));

            const listContainer = document.getElementById('notif-list');
            if(updates.length === 0) {
                listContainer.innerHTML = `<p style="font-size:12px; color:var(--subtext-color); text-align:center; padding:10px;">No new updates.</p>`;
                return;
            }

            let html = '';
            updates.forEach(item => {
                let hoursAgo = Math.floor((currentTime - item.time) / (1000 * 60 * 60));
                html += `
                    <div class="notif-item">
                        ${item.title}
                        <span>${hoursAgo === 0 ? 'Just now' : hoursAgo + ' hours ago'}</span>
                    </div>
                `;
            });
            listContainer.innerHTML = html;
        }

        function openToolModal() {
            document.getElementById('tool-modal').style.display = 'block';
        }

        function closeToolModal() {
            document.getElementById('tool-modal').style.display = 'none';
        }

        function switchTab(type) {
            if(type === 'git') {
                document.getElementById('git-tab-content').style.display = 'block';
                document.getElementById('yt-tab-content').style.display = 'none';
                document.getElementById('tab-git-btn').classList.add('active');
                document.getElementById('tab-yt-btn').classList.remove('active');
            } else {
                document.getElementById('git-tab-content').style.display = 'none';
                document.getElementById('yt-tab-content').style.display = 'block';
                document.getElementById('tab-git-btn').classList.remove('active');
                document.getElementById('tab-yt-btn').classList.add('active');
            }
        }

        async function fetchGitHubData() {
            const username = document.getElementById('github-user').value.trim();
            const token = document.getElementById('github-token').value.trim();
            const loader = document.getElementById('git-loader');
            const resBox = document.getElementById('git-results');

            if(!username) {
                alert('Please enter GitHub username');
                return;
            }

            loader.style.display = 'block';
            resBox.style.display = 'none';

            const headers = {};
            if(token) headers['Authorization'] = `token ${token}`;

            try {
                const uRes = await fetch(`https://api.github.com/users/${username}`, { headers });
                const uData = await uRes.json();

                if(uData.message === "Not Found") {
                    loader.style.display = 'none';
                    alert('User not found!');
                    return;
                }

                const rRes = await fetch(`https://api.github.com/users/${username}/repos?sort=updated&per_page=10`, { headers });
                const rData = await rRes.json();

                loader.style.display = 'none';
                resBox.style.display = 'block';

                let reposHTML = '';
                if(Array.isArray(rData)) {
                    rData.forEach(repo => {
                        reposHTML += `<div class="repo-item"><i class="fa-regular fa-bookmark"></i> ${repo.name} <br> <span style="color:var(--subtext-color);">⭐ ${repo.stargazers_count} | 🍴 ${repo.forks_count}</span></div>`;
                    });
                }

                resBox.innerHTML = `
                    <img src="${uData.avatar_url}" class="profile-img">
                    <h3 style="text-align:center;">${uData.name || uData.login}</h3>
                    <p style="text-align:center; color:var(--subtext-color); font-size:12px;">@${uData.login}</p>
                    <p style="text-align:center; font-size:12px; margin-top:5px; color:var(--text-color);">${uData.bio || 'No bio available.'}</p>
                    <div class="stats-grid">
                        <div class="stat-card"><h3>${uData.followers}</h3><p>FOLLOWERS</p></div>
                        <div class="stat-card"><h3>${uData.public_repos}</h3><p>REPOS</p></div>
                        <div class="stat-card"><h3>${uData.following}</h3><p>FOLLOWING</p></div>
                        <div class="stat-card"><h3>${uData.created_at.split('T')[0]}</h3><p>JOINED</p></div>
                    </div>
                    <div style="margin-top:15px; font-weight:bold; font-size:14px;"><i class="fa-solid fa-book"></i> Top Repositories</div>
                    ${reposHTML || '<p style="font-size:12px; color:var(--subtext-color);">No public repos.</p>'}
                `;
            } catch(e) {
                loader.style.display = 'none';
                alert('Error fetching data.');
            }
        }

        function fetchYTData() {
            const link = document.getElementById('yt-link').value.trim();
            const resBox = document.getElementById('yt-results');

            if(!link) {
                alert('Please enter video link');
                return;
            }

            let videoId = '';
            if(link.includes('v=')) {
                videoId = link.split('v=')[1].split('&')[0];
            } else if(link.includes('youtu.be/')) {
                videoId = link.split('youtu.be/')[1].split('?')[0];
            }

            if(!videoId) {
                alert('Invalid YouTube URL');
                return;
            }

            resBox.style.display = 'block';
            resBox.innerHTML = `
                <img src="https://img.youtube.com/vi/${videoId}/hqdefault.jpg" style="width:100%; border-radius:8px; margin-bottom:10px;">
                <h4 style="font-size:14px;">YouTube Video Info</h4>
                <p style="font-size:12px; color:var(--subtext-color); margin-top:5px;">Video ID: ${videoId}</p>
                <a href="https://img.youtube.com/vi/${videoId}/maxresdefault.jpg" target="_blank" style="display:block; margin-top:10px; color:#ff4757; text-decoration:none; font-weight:bold; font-size:13px;"><i class="fa-solid fa-download"></i> View HD Thumbnail</a>
            `;
        }
    </script>
</body>
</html>
