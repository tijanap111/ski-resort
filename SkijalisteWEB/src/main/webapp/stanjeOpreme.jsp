<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Stanje Opreme - Skijalište</title>
    <style>
        :root { --glavna: #2c3e50; --zuta: #ffc107; }
        body { font-family: sans-serif; background: #fdfdfd; padding: 40px; }
        .box { background: white; border: 2px solid var(--glavna); padding: 20px; max-width: 800px; margin: auto; }
        h2 { border-bottom: 3px solid var(--zuta); display: inline-block; text-transform: uppercase; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th { background: var(--glavna); color: white; padding: 12px; text-align: left; }
        td { padding: 10px; border-bottom: 1px solid #eee; }
        tr:hover { background: #fff9e6; }
        .back-link { display: inline-block; margin-top: 20px; color: var(--glavna); font-weight: bold; }
    </style>
</head>
<body>
    <div class="box">
        <h2>📦 Stanje Opreme na Skijalištu</h2>
        <table>
            <thead>
                <tr>
                    <th>Naziv opreme</th>
                    <th>Tip</th>
                    <th>Količina</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="o" items="${opremaList}">
                    <tr>
                        <td>${o.naziv}</td>
                        <td>${o.tip}</td>
                        <td>${o.kolicina}</td>
                        <td><span style="color: ${o.kolicina > 0 ? 'green' : 'red'}">
                            ${o.kolicina > 0 ? 'Dostupno' : 'Nema na stanju'}
                        </span></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <a href="${pageContext.request.contextPath}/nalog/admin" class="back-link">← Nazad na Admin Panel</a>
    </div>
</body>
</html>