<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Skijalište - Prijava</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@700&display=swap" rel="stylesheet">

    <style>
        :root {
            --solid-dark-blue: #0b1d33; 
            --akcenat: #7EC8E3;                
            --tekst: #ffffff;
            --glass: rgba(255, 255, 255, 0.08); 
        }

        body, html {
            margin: 0; padding: 0; height: 100vh; width: 100%;
            font-family: 'Montserrat', sans-serif;
            overflow: hidden;
        }

        .hero-wrapper {
            background-image: linear-gradient(rgba(11, 29, 51, 0.5), rgba(11, 29, 51, 0.5)), 
                              url('${pageContext.request.contextPath}/images/pozadina.jpeg');
            background-size: cover;
            background-position: center;
            height: 100vh;
            width: 100vw;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .hero-content { 
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center; 
            color: white; 
            z-index: 2; 
        }

        .hero-title {
            font-family: 'Oswald', sans-serif;
            font-size: 75px;
            letter-spacing: 12px;
            text-transform: uppercase;
            margin: 0;
            text-shadow: 0 10px 30px rgba(0,0,0,0.5);
        }

        .hero-subtitle {
            font-size: 15px; font-weight: 300; letter-spacing: 4px;
            text-transform: uppercase; opacity: 0.9; margin-bottom: 40px;
        }

        .landing-actions { 
            display: flex; 
            gap: 20px; 
            margin-bottom: 35px; 
        }

        .btn-landing {
            padding: 16px 32px; border-radius: 50px; text-decoration: none;
            font-weight: 700; font-size: 12px; text-transform: uppercase;
            letter-spacing: 2px; transition: all 0.3s ease;
            display: inline-block;
        }

        .btn-staze { background: var(--akcenat); color: var(--solid-dark-blue); border: none; }
        .btn-auth { background: var(--glass); border: 1px solid rgba(255,255,255,0.2); color: white; }
        .btn-landing:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.4); }

        .login-card {
            background: rgba(11, 29, 51, 0.85);
            padding: 40px; border-radius: 24px;
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            width: 340px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.5);
        }

        .input-group { margin-bottom: 20px; text-align: left; }
        .input-group label { display: block; font-size: 11px; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 8px; opacity: 0.7; }
        
        .input-group input {
            width: 100%; padding: 14px; border-radius: 10px; border: 1px solid rgba(255,255,255,0.1);
            background: rgba(255,255,255,0.05); color: white; box-sizing: border-box;
            transition: 0.3s;
        }

        .input-group input:focus { outline: none; border-color: var(--akcenat); background: rgba(255,255,255,0.15); }
    </style>
</head>
<body>

<div class="hero-wrapper">
    <div class="hero-content">
        <h1 class="hero-title">SKIJALIŠTE</h1>
        <p class="hero-subtitle">Planinska avantura na dohvat ruke</p>
        
        <div class="landing-actions">
            <%-- DODATA APSOLUTNA PUTANJA --%>
            <a href="${pageContext.request.contextPath}/staze/sveStaze" class="btn-landing btn-staze">
                POGLEDAJ STAZE
            </a>
            <a href="${pageContext.request.contextPath}/nalog/getRegister" class="btn-landing btn-auth">
                REGISTRACIJA
            </a>
        </div>

        <div class="login-card">
            <c:if test="${param.success}"><p style="color: #7ED8A3; font-size: 13px; margin-bottom: 20px;">Registracija uspešna!</p></c:if>
            <c:if test="${param.error}"><p style="color: #FF8A8A; font-size: 13px; margin-bottom: 20px;">Pogrešan email ili lozinka!</p></c:if>
            
            <form action="${pageContext.request.contextPath}/nalog/loginForm" method="post">
                <div class="input-group">
                    <label>Email adresa</label>
                    <input type="text" name="email" placeholder="ime@email.com" required>
                </div>
                <div class="input-group">
                    <label>Lozinka</label>
                    <input type="password" name="lozinka" placeholder="••••••••" required>
                </div>
                <button type="submit" class="btn-landing btn-staze" style="width: 100%; cursor: pointer; margin-top: 10px;">
                    PRIJAVI SE
                </button>
            </form>
        </div>
    </div>
</div>

</body>
</html>