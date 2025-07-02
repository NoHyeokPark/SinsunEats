<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="left-sticky-menu">
    <div class="menu-box">
        <button class="to-top-btn" onclick="window.scrollTo(0, 0)">▲ 맨 위로</button>
    </div>
</div>
<style>
.left-sticky-menu {
    position: fixed;
    right: 20px;
    top: 90%;
    transform: translateY(-50%);
    z-index: 1000;
    transition: top 0.2s ease;
}
.menu-box {
    background-color: #fff;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
    padding: 20px;
    width: 120px;
}
.to-top-btn {
    display: block;
    width: 100%;
    padding: 10px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 1em;
    font-weight: 600;
    cursor: pointer;
    transition: background-color 0.3s ease;
}
.to-top-btn:hover {
    background-color: #0056b3;
}
.category-title {
    font-size: 1.2em;
    font-weight: bold;
    margin: 0 0 15px 0;
    color: #333;
}
.category-list {
    list-style: none;
    padding: 0;
    margin: 0;
}
.category-list li {
    margin-bottom: 10px;
}
.category-list li a {
    display: block;
    padding: 8px 12px;
    background-color: #f9f9f9;
    border-radius: 6px;
    color: #333;
    text-decoration: none;
    transition: background-color 0.2s ease;
}
.category-list li a:hover {
    background-color: #e9ecef;
}
</style>