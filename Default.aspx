<%@ Page Language="vb" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="GeneratorWebForm" %>
<%@ OutputCache Duration="60" VaryByParam="q" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>プロ生ちゃん 壁紙ジェネレーター 2</title>
    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.1.1/css/bootstrap-combined.min.css" rel="stylesheet" />
    <style>
        body {
            margin-top: 20px;
            color: #333;
            font-family: 'ヒラギノ角ゴ Pro W3','Hiragino Kaku Gothic Pro','メイリオ',Meiryo,sans-serif;
            line-height: 1.6;
        }

        h1 {
            font-size: 20px;
            color: #888;
        }

        input {
        }

        p {
            font-size: 12px;
        }

        #social {
            display: none;
        }

        footer {
            margin-top: 40px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>プロ生ちゃん 壁紙ジェネレーター 2</h1>
        <form id="form1" runat="server" class="form-inline">
            <label for="q">画像の URL: </label>
            <input type="text" id="q" size="30" />
            <input type="submit" value="Generate" id="btn" />
        </form>
        <p>
            入力したメッセージおよび作成した壁紙は、送信や公開はされません。<br />
            また、サーバーで保存・管理していません。
        </p>
        <a href="http://pronama.wordpress.com/pronama/" class="btn">&laquo; プロ生ちゃん（暮井 慧）</a>

        <hr />
        <div id="loading" style="display: none;">
            <img src="loading.gif" />
            Loading...
        </div>
        <div id="error" style="display: none;">
            <img src="error.gif" />
            Error!!
        </div>
        <div id="result">
            <img src="wallpaper.png" />
        </div>
        <footer>
        </footer>
    </div>



    <script src="//codeorigin.jquery.com/jquery-1.10.2.min.js"></script>
    <script>
        $(function () {
            $("#btn").click(
                function () {
                    $("#error").hide();
                    $("#result").empty();
                    $("#loading").show();

                    var q = $("#q").val();
                    var img = $("<img>")
                        .one('load', function () {
                            $("#loading").hide();
                        })
                        .one('error', function () {
                            $("#loading").hide();
                            $("#result").empty();
                            $("#error").show();
                        })
                        .attr("src", "?q=" + q);

                    $("#result").empty().append(img);
                    return false;
                }
            );
        })
    </script>
</body>
</html>