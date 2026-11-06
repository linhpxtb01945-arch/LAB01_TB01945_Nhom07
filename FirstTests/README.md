# LAB 02 – SELENIUM WEBDRIVER CƠ BẢN

**Họ và tên:** Phùng Xuân Linh  
**Mã sinh viên:** TB01945  
**Nhóm:** 07

## A. LOCATOR ANALYSIS

Website kiểm thử: https://www.saucedemo.com/

### 1. Username

- Locator 1: `By.Id("user-name")`
- Locator 2: `By.Name("user-name")`
- Locator được chọn: `By.Id("user-name")`
- Lý do: ID xác định trực tiếp phần tử, ngắn gọn và dễ sử dụng.

### 2. Password

- Locator 1: `By.Id("password")`
- Locator 2: `By.Name("password")`
- Locator được chọn: `By.Id("password")`
- Lý do: ID rõ ràng, dễ xác định và sử dụng trong Selenium.

### 3. Login Button

- Locator 1: `By.Id("login-button")`
- Locator 2: `By.Name("login-button")`
- Locator được chọn: `By.Id("login-button")`
- Lý do: ID duy nhất, giúp xác định chính xác nút đăng nhập.

### 4. Product Name

- Locator 1: `By.ClassName("inventory_item_name")`
- Locator 2: `By.CssSelector("[data-test='inventory-item-name']")`
- Locator được chọn: `By.CssSelector("[data-test='inventory-item-name']")`
- Lý do: Thuộc tính `data-test` được thiết kế để hỗ trợ kiểm thử, giúp locator dễ đọc và ổn định.

### 5. Product Price

- Locator 1: `By.ClassName("inventory_item_price")`
- Locator 2: `By.CssSelector("[data-test='inventory-item-price']")`
- Locator được chọn: `By.CssSelector("[data-test='inventory-item-price']")`
- Lý do: Thuộc tính `data-test` giúp xác định chính xác phần tử giá sản phẩm.

## B. SCREENSHOTS – LOCATOR VERIFICATION

Chèn ảnh kết quả kiểm tra locator bằng DevTools Ctrl + F tại đây.

- Ảnh A1: Username.
- Ảnh A2: Password.
- Ảnh A3: Login Button.
- Ảnh A4: Product Name.
- Ảnh A5: Product Price.

## D. AI INTEGRATION

### 1. Element được chọn

Tên phần tử: Nút Add to cart của sản phẩm Sauce Labs Backpack.

### 2. HTML của phần tử

Dán nội dung `outerHTML` đã sao chép từ DevTools vào đây.

### 3. Prompt sử dụng AI

Dựa vào đoạn HTML của nút Add to cart, hãy đề xuất hai locator Selenium bằng C#. Ưu tiên sử dụng ID hoặc thuộc tính data-test. Giải thích locator nào ổn định và phù hợp hơn khi viết kiểm thử tự động.

### 4. Kết quả AI đề xuất

- Locator 1: `By.Id("add-to-cart-sauce-labs-backpack")`
- Locator được chọn: `By.Id("add-to-cart-sauce-labs-backpack")`

### 5. Kiểm tra locator

Sử dụng DevTools Ctrl + F để kiểm tra locator:

`#add-to-cart-sauce-labs-backpack`

Kết quả mong đợi: `1 of 1`.

### 6. Nhận xét

AI đề xuất locator sử dụng ID cho nút Add to cart. Đây là locator ngắn gọn và dễ sử dụng trong Selenium. Sau khi kiểm tra bằng DevTools, có thể xác định locator có tìm đúng phần tử hay không. Việc sử dụng AI giúp tiết kiệm thời gian và hỗ trợ lựa chọn locator phù hợp hơn.