# About/ModIcon.png: a 52x52 square of the mod's own south-facing sprite - head, ears and the
# top of the spotted back - scaled to 128. The full sprite is 44x93, which at the ~32 px the
# mod list actually draws reads as a thin vertical smudge. No new art: this is their texture.
Add-Type -AssemblyName System.Drawing
$src = 'C:\Users\nelim\Documents\rimworld\Dalmatians\Mod\Textures\Things\Pawn\Animal\Dalmatian\Dalmatian_south.png'
$dst = 'C:\Users\nelim\Documents\rimworld\Dalmatians\Mod\About\ModIcon.png'
$bmp = [System.Drawing.Bitmap]::FromFile($src)
$out = New-Object System.Drawing.Bitmap 128,128,([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($out)
$g.InterpolationMode=[System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.PixelOffsetMode=[System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g.Clear([System.Drawing.Color]::Transparent)
$g.DrawImage($bmp,(New-Object System.Drawing.Rectangle 0,0,128,128),(New-Object System.Drawing.Rectangle 38,30,52,52),[System.Drawing.GraphicsUnit]::Pixel)
$g.Dispose(); $out.Save($dst,[System.Drawing.Imaging.ImageFormat]::Png); $out.Dispose(); $bmp.Dispose()
"$dst : $((Get-Item $dst).Length) bytes"
