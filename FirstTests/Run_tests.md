# Lab 6 – Các lệnh chạy test

Chạy trong Developer PowerShell, tại thư mục chứa `FirstTests.csproj`.
Khi chạy song song hoặc chụp báo cáo, đặt `"Headless": true` trong `Config/appsettings.json`.

## Phần A – Chạy chọn lọc theo [Category]

```
dotnet test --filter "Category=Smoke"
dotnet test --filter "Category!=Slow"
dotnet test --filter "Category=Login"
dotnet test --filter "Category=Smoke|Category=Inventory"
```

## Phần B – Xem nhật ký

```
dotnet test -l "console;verbosity=detailed"

# Có cả ca đậu và 1 ca rớt (ca D1 cố ý rớt, đánh dấu Explicit nên phải chọn theo tên):
dotnet test --filter "Name=OpenSauceDemo_CheckPageTitle|Name=D1_CoY_LamRot_DeChupAnh" -l "console;verbosity=detailed"

# Vừa xem vừa lưu nhật ký ra file:
dotnet test --filter "Name=OpenSauceDemo_CheckPageTitle|Name=D1_CoY_LamRot_DeChupAnh" -l "console;verbosity=detailed" 2>&1 | Tee-Object -FilePath nhatky.txt
```

## Phần C – Báo cáo HTML từ .trx

```
dotnet test --logger "trx;LogFileName=ketqua.trx"
powershell -ExecutionPolicy Bypass -File Tools/trx-to-html.ps1
# Kết quả: TestResults/ketqua.trx và TestResults/baocao.html
```

(Nếu dùng công cụ trxlog2html theo đề thì chạy công cụ đó trên TestResults/ketqua.trx.)

## Phần D – Đo thời gian tuần tự và song song

```
# 1) TUẦN TỰ: khi CHƯA có file AssemblyInfo.cs
dotnet test

# 2) Chép file _ThemSauKhiDoTuanTu/AssemblyInfo.cs.txt ra thư mục project, đổi tên thành AssemblyInfo.cs, rồi chạy lại -> SONG SONG
dotnet test
```

Đọc dòng cuối của kết quả: `Total tests`, `Passed`, `Failed` và `Total time`.
