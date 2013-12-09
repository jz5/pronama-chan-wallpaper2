Imports System.Drawing
Imports System.Net

Public Class GeneratorWebForm
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim q = Context.Request.QueryString.Get("q")
        If Not Uri.IsWellFormedUriString(q, UriKind.Absolute) Then
            Exit Sub
        End If
        Dim url = New Uri(q)

        Try
            Dim webBmp As Bitmap
            Using wc = New WebClient
                webBmp = New Bitmap(wc.OpenRead(url))
            End Using

            Dim dst = New Rectangle(754, 18, 1110, 807) ' 描画先の位置・大きさ
            Dim src = New Rectangle(0, 0, webBmp.Width, webBmp.Height) ' 参照画像の位置・大きさ

            If dst.Width / dst.Height < webBmp.Width / webBmp.Height Then
                Dim w = dst.Width / (dst.Height / webBmp.Height)
                src.X = Convert.ToInt32((webBmp.Width - w) / 2)
                src.Width = Convert.ToInt32(w)
            Else
                Dim h = dst.Height / (dst.Width / webBmp.Width)
                src.Y = Convert.ToInt32((webBmp.Height - h) / 2)
                src.Height = Convert.ToInt32(h)
            End If

            Dim wallBmp = New Bitmap(System.IO.Path.Combine(Server.MapPath("./"), "wallpaper.png"))
            Dim outBmp = New Bitmap(wallBmp.Width, wallBmp.Height)

            Using g = Graphics.FromImage(outBmp)
                g.CompositingQuality = Drawing2D.CompositingQuality.HighQuality
                g.DrawImage(webBmp, dst, src, GraphicsUnit.Pixel)
                g.DrawImage(wallBmp, 0, 0, wallBmp.Width, wallBmp.Height)
            End Using

            Response.ContentType = "image/png"
            Response.Flush()
            outBmp.Save(Response.OutputStream, Imaging.ImageFormat.Png)
            Response.End()

        Catch ex As Exception
            Exit Sub
        End Try
    End Sub

End Class