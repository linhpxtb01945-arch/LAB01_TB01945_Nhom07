## Lab 6 – Thread-safety (Phần D)

Framework thread-safe vì `driver` là **field thường (không static)** trong `BaseTest`: mỗi class test có đối tượng riêng nên có trình duyệt riêng, được tạo trong `[SetUp]` và đóng trong `[TearDown]`; các ca trong cùng một class chạy tuần tự trên một luồng nên không giẫm lên nhau. Dữ liệu dùng chung (cấu hình) chỉ đọc và nạp một lần qua `Lazy`; `DriverFactory` và `Log` là static nhưng không giữ trạng thái. Nếu `driver` là static thì các luồng sẽ dùng chung một trình duyệt và sinh ra ca đỏ ngẫu nhiên.

Lưu ý: chỉ bật `ParallelScope.Fixtures`. Nếu nâng lên `Children`, mặc định các ca trong cùng class dùng chung một đối tượng (và field `driver`), nên phải thêm `[FixtureLifeCycle(LifeCycle.InstancePerTestCase)]`.

## Lab 6 – Thẩm định AI (Phần E)

(Dán prompt, toàn bộ kết quả AI trả về và phần phân tích ≥ 2 ca không dùng được. Nội dung phải lấy từ lần làm thật của bạn.)
