// 从'../model/bookModel'导入book
import book, { bookList, listInfo } from '../model/bookModel';

@Entry
@Component
struct ShopPage {
  @State bookList: listInfo[] = [];
  @State totalCount: number = 0;
  @State newBook: listInfo = {  title: '', author: '', cover: '', description: '' };

  aboutToAppear() {
    // 加载书籍数据
    this.loadShopInfo();
  }

  build() {
    Column({ space: 120 }) {
      List({ space: 10 }) {
        ForEach(this.bookList, book => {
          ListItem() {
            // 在这里构建每个书籍的展示内容
           Row(){
             Text(book.title)
             // Button("删除") {
             //   this.deleteBook(book.id);
             // }
           }
          }
        })
      }
      .width('100%')
      .layoutWeight(1)

      // 新增图书表单
      // Column({ space: 10 }) {
      //   TextField().placeholder("标题").value(this.newBook.title).onChange((value) => this.newBook.title = value)
      //   TextField().placeholder("作者").value(this.newBook.author).onChange((value) => this.newBook.author = value)
      //   TextField().placeholder("封面").value(this.newBook.cover).onChange((value) => this.newBook.cover = value)
      //   TextField().placeholder("描述").value(this.newBook.description).onChange((value) => this.newBook.description = value)
      //   Button("新增图书") {
      //     this.addBook();
      //   }
      // }
      // .padding(10)
    }
    .width('100%')
    .height('100%')
    .padding(10)
    .backgroundColor('#e1e2e3')
  }

  loadShopInfo() {
    // 加载数据
    book.getShopListByAxios()
      .then(res => {
        this.bookList = res.list || [];
        this.totalCount = res.totalCount;
        console.log('this.bookList', this.bookList);
        console.log('totalCount', this.totalCount);
      })
      .catch(error => {
        console.log('加载书籍信息失败', error);
      });
  }

  addBook() {
    // 新增图书
    book.addBook(this.newBook)
      .then(() => {
        this.loadShopInfo(); // 刷新列表
      })
      .catch(error => {
        console.log('新增图书失败', error);
      });
  }

  deleteBook(id: number) {
    // 删除图书
    book.deleteBook(id)
      .then(() => {
        this.loadShopInfo(); // 刷新列表
      })
      .catch(error => {
        console.log('删除图书失败', error);
      });
  }
}
