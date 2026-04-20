<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Skijalište - Admin Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@700&display=swap" rel="stylesheet">
    <style>
        :root {
            --solid-dark-blue: #0b1d33; 
            --akcenat: #7EC8E3;                
            --tekst: #ffffff;
            --polje-dugme: rgba(255, 255, 255, 0.08); 
            --zelena: #2ecc71;
            --crvena: #e74c3c;
        }

        body, html {
            margin: 0; padding: 0;
            min-height: 100vh;
            width: 100%;
            font-family: 'Montserrat', sans-serif;
            background-image: url('${pageContext.request.contextPath}/images/pozadina.jpeg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: white;
        }

        .navbar {
            width: 100%;
            background: rgba(0, 0, 0, 0.6);
            padding: 15px 0;
            display: flex;
            justify-content: center;
            align-items: center;
            position: fixed; top: 0; z-index: 1000;
            backdrop-filter: blur(10px);
        }

        .logo-naslov {
            font-family: 'Oswald', sans-serif;
            font-size: 24px;
            letter-spacing: 5px;
            text-transform: uppercase;
            margin: 0;
        }

        .main-wrapper {
            padding: 100px 20px 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 30px;
        }

        .admin-card {
            background: rgba(11, 29, 51, 0.9);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 30px;
            width: 95%;
            max-width: 1100px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.5);
        }

        .welcome-bar {
            padding-left: 15px;
            margin-bottom: 30px;
        }

        h2, h3 {
            font-family: 'Oswald', sans-serif;
            text-transform: uppercase;
            letter-spacing: 2px;
            color: var(--akcenat);
        }

        .grid-top {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-bottom: 30px;
        }

        .table-container {
            width: 100%;
            overflow-x: auto;
            margin-top: 15px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(255,255,255,0.03);
            border-radius: 10px;
            overflow: hidden;
        }

        th {
            background: rgba(126, 200, 227, 0.2);
            color: var(--akcenat);
            text-transform: uppercase;
            font-size: 11px;
            padding: 15px;
            text-align: left;
        }

        td {
            padding: 12px 15px;
            border-bottom: 1px solid rgba(255,255,255,0.05);
            font-size: 13px;
        }

        tr:hover { background: rgba(255,255,255,0.05); }

        .report-form {
            background: var(--polje-dugme);
            padding: 20px;
            border-radius: 15px;
        }

        .input-group { margin-bottom: 15px; }
        .input-group label { display: block; font-size: 10px; font-weight: 700; text-transform: uppercase; margin-bottom: 5px; opacity: 0.6; }
        
        input[type="date"] {
            width: 100%;
            padding: 10px;
            background: var(--solid-dark-blue);
            border: 1px solid rgba(255,255,255,0.2);
            border-radius: 8px;
            color: white;
            font-family: inherit;
        }

        .btn-main {
            background: var(--akcenat);
            color: var(--solid-dark-blue);
            border: none;
            padding: 12px;
            border-radius: 8px;
            font-weight: 700;
            text-transform: uppercase;
            cursor: pointer;
            width: 100%;
            transition: 0.3s;
        }

        .btn-main:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(126, 200, 227, 0.4); }

        .link-item {
            display: flex;
            align-items: center;
            padding: 15px;
            background: var(--polje-dugme);
            border-radius: 10px;
            text-decoration: none;
            color: white;
            font-weight: 600;
            transition: 0.3s;
            border: 1px solid transparent;
        }

        .link-item:hover { border-color: var(--akcenat); background: rgba(126, 200, 227, 0.1); }

        .logout-btn {
            position: fixed; bottom: 30px; right: 30px;
            background: var(--crvena);
            color: white;
            padding: 12px 25px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 700;
            font-size: 11px;
            text-transform: uppercase;
            box-shadow: 0 10px 20px rgba(0,0,0,0.3);
        }
    </style>
</head>
<body>

<div class="navbar">
    <h1 class="logo-naslov">~ SKIJALIŠTE ~</h1>
</div>

<div class="main-wrapper">
    <div class="admin-card">
        <div class="welcome-bar">
            <p style="margin: 0; font-size: 12px; opacity: 0.6;">SISTEMSKI ADMINISTRATOR</p>
            <h2 style="margin: 5px 0 0 0; color: white;">Dobrodošli nazad</h2>
        </div>

        <div class="grid-top">
            <div class="report-form">
                <h3>Izveštaji</h3>
                <p style="font-size: 12px; opacity: 0.7; margin-bottom: 15px;">Generišite PDF spisak novih korisnika:</p>
                <form action="${pageContext.request.contextPath}/nalog/getNoviKorisniciReport" method="get">
                    <div class="input-group">
                        <label>Od datuma</label>
                        <input type="date" name="datumOd" required>
                    </div>
                    <div class="input-group">
                        <label>Do datuma</label>
                        <input type="date" name="datumDo" required>
                    </div>
                    <button type="submit" class="btn-main">Štampaj PDF</button>
                </form>
            </div>

            <div style="display: flex; flex-direction: column; gap: 15px;">
                <a href="${pageContext.request.contextPath}/staze/sveStaze" class="link-item">
                    Upravljanje stazama
                </a>
            </div>
        </div>

        <div class="table-section">
            <h3>Inventar ski opreme</h3>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Naziv</th>
                            <th>Tip</th>
                            <th>Ukupno</th>
                            <th>Dostupno</th>
                            <th>Cena/Dan</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="o" items="${svaOprema}">
                            <tr>
                                <td>${o.opremaId}</td>
                                <td style="font-weight: 600;">${o.naziv}</td>
                                <td>${o.tip}</td>
                                <td>${o.ukupnaKolicina}</td>
                                <td style="color: ${o.dostupnaKolicina > 0 ? 'var(--zelena)' : 'var(--crvena)'}; font-weight: 700;">
                                    ${o.dostupnaKolicina}
                                </td>
                                <td>${o.cenaPoDanu} RSD</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <br><br>

        <div class="table-section">
            <h3>Aktivna zaduženja opreme</h3>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Korisnik</th>
                            <th>Oprema</th>
                            <th>Period (Od - Do)</th>
                            <th>Dani</th>
                            <th>Ukupna Cena</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="i" items="${svaIznajmljivanja}">
                            <tr>
                                <td style="font-weight: 600;">${i.korisnik.ime} ${i.korisnik.prezime}</td>
                                <td>${i.skiOprema.naziv}</td>
                                <td style="font-size: 11px; opacity: 0.8;">
                                    <fmt:formatDate value="${i.datumOd}" pattern="dd.MM HH:mm" /> - 
                                    <fmt:formatDate value="${i.datumDo}" pattern="dd.MM HH:mm" />
                                </td>
                                <td>${i.brojDana}</td>
                                <td style="color: var(--akcenat); font-weight: 700;">${i.ukupnaCena} RSD</td>
                                <td>
                                    <span style="background: rgba(46, 204, 113, 0.2); color: var(--zelena); padding: 4px 10px; border-radius: 4px; font-size: 10px; font-weight: 700;">
                                        ${i.status}
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<a href="${pageContext.request.contextPath}/nalog/logout" class="logout-btn">ODJAVI SE</a>

</body>
</html>