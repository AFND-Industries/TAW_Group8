<%--
  Created by IntelliJ IDEA.
  User: elgam
  Date: 23/06/2024
  Time: 16:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="toast-container position-fixed bottom-0 end-0 p-3">
    <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <div class="rounded me-2" style="background-color: green; width: 20px; height: 20px"></div>
            <strong id="toast-title" class="me-auto">Titulo</strong>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div id="toast-body" class="toast-body">
            Cuerpo
        </div>
    </div>
</div>