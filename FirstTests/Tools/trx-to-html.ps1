# Chuyển file .trx thành báo cáo HTML (không cần cài thêm công cụ nào).
# Cách dùng (chạy ở thư mục chứa FirstTests.csproj):
#   dotnet test --logger "trx;LogFileName=ketqua.trx"
#   powershell -ExecutionPolicy Bypass -File Tools/trx-to-html.ps1
param(
    [string]$Trx = "TestResults/ketqua.trx",
    [string]$Out = "TestResults/baocao.html"
)

if (-not (Test-Path $Trx)) {
    Write-Error "Không thấy file $Trx. Hãy chạy dotnet test --logger ""trx;LogFileName=ketqua.trx"" trước."
    exit 1
}

[xml]$x = Get-Content -Path $Trx -Encoding UTF8
$ns = New-Object System.Xml.XmlNamespaceManager($x.NameTable)
$ns.AddNamespace("t", "http://microsoft.com/schemas/VisualStudio/TeamTest/2010")

# Tổng hợp
$c       = $x.SelectSingleNode("//t:ResultSummary/t:Counters", $ns)
$tong    = [int]$c.GetAttribute("total")
$dau     = [int]$c.GetAttribute("passed")
$rot     = [int]$c.GetAttribute("failed")
$khac    = $tong - $dau - $rot
$times   = $x.SelectSingleNode("//t:Times", $ns)
$batDau  = [datetime]$times.GetAttribute("start")
$ketThuc = [datetime]$times.GetAttribute("finish")
$thoiGian = ($ketThuc - $batDau).ToString("hh\:mm\:ss")

# Tên class của từng ca test
$lop = @{}
foreach ($u in $x.SelectNodes("//t:UnitTest", $ns)) {
    $lop[$u.GetAttribute("id")] =
        $u.SelectSingleNode("t:TestMethod", $ns).GetAttribute("className")
}

# Từng ca test
$dong = New-Object System.Collections.Generic.List[object]
foreach ($r in $x.SelectNodes("//t:UnitTestResult", $ns)) {
    $loi = $r.SelectSingleNode("t:Output/t:ErrorInfo/t:Message", $ns)
    $dong.Add([pscustomobject]@{
        Lop     = $lop[$r.GetAttribute("testId")]
        Ten     = $r.GetAttribute("testName")
        KetQua  = $r.GetAttribute("outcome")
        ThoiGian = $r.GetAttribute("duration")
        Loi     = if ($loi) { $loi.InnerText.Trim() } else { "" }
    })
}
$dong = $dong | Sort-Object Lop, Ten

function Enc($s) { [System.Net.WebUtility]::HtmlEncode([string]$s) }

$sb = New-Object System.Text.StringBuilder
[void]$sb.AppendLine('<!DOCTYPE html><html><head><meta charset="utf-8"><title>Báo cáo kiểm thử</title>')
[void]$sb.AppendLine('<style>body{font-family:Arial,sans-serif;margin:2rem;color:#333}h1{margin-bottom:.2rem}')
[void]$sb.AppendLine('.sum{display:flex;gap:1rem;margin:1.2rem 0}.sum div{padding:.8rem 1.4rem;background:#eee;font-size:1.1rem}')
[void]$sb.AppendLine('.ok{color:#2e7d32;font-weight:bold}.bad{color:#c62828;font-weight:bold}')
[void]$sb.AppendLine('table{border-collapse:collapse;width:100%}td,th{border:1px solid #ccc;padding:.4rem .6rem;text-align:left;font-size:.9rem}')
[void]$sb.AppendLine('th{background:#dde6f3}tr.Passed td:nth-child(3){color:#2e7d32;font-weight:bold}tr.Failed{background:#fdecea}tr.Failed td:nth-child(3){color:#c62828;font-weight:bold}')
[void]$sb.AppendLine('pre{white-space:pre-wrap;margin:0;font-size:.8rem;color:#c62828}</style></head><body>')
[void]$sb.AppendLine('<h1>Báo cáo kiểm thử</h1>')
[void]$sb.AppendLine("<div>Bắt đầu: $batDau &nbsp;|&nbsp; Tổng thời gian: $thoiGian</div>")
[void]$sb.AppendLine("<div class='sum'><div>Tổng số ca: <b>$tong</b></div><div class='ok'>Đậu: $dau</div><div class='bad'>Rớt: $rot</div><div>Khác: $khac</div></div>")
[void]$sb.AppendLine('<table><tr><th>Class</th><th>Ca test</th><th>Kết quả</th><th>Thời gian</th></tr>')
foreach ($d in $dong) {
    [void]$sb.AppendLine("<tr class='$($d.KetQua)'><td>$(Enc $d.Lop)</td><td>$(Enc $d.Ten)</td><td>$(Enc $d.KetQua)</td><td>$(Enc $d.ThoiGian)</td></tr>")
    if ($d.Loi) {
        [void]$sb.AppendLine("<tr class='Failed'><td colspan='4'><pre>$(Enc $d.Loi)</pre></td></tr>")
    }
}
[void]$sb.AppendLine('</table></body></html>')

New-Item -ItemType Directory -Force -Path (Split-Path -Parent $Out) | Out-Null
Set-Content -Path $Out -Value $sb.ToString() -Encoding UTF8
Write-Host "Đã tạo $Out  (tổng $tong, đậu $dau, rớt $rot)"
