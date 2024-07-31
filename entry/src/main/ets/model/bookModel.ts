import axios from '@ohos/axios';

export interface listInfo {
  id?: number;
  title: string;
  author: string;
  cover: string;
  description: string;
}

export interface bookList {
  list: listInfo[];
  totalCount: number;
}

class bookModel {
  baseURL: string = 'http://localhost:3000';
  pageNo: number = 1;

  /**
   * 基于axios实现异步查询书籍
   * @returns Promise<bookList>
   */
  getShopListByAxios(): Promise<bookList> {
    return new Promise((resolve, reject) => {
      axios.get(`${this.baseURL}/book/list`, {
        params: { pageNo: this.pageNo, pageSize: 3 }
      })
        .then(resp => {
          if (resp.status === 200 && resp.data && resp.data.data) {
            // 查询成功
            console.log('testTag', '查询书籍成功！', JSON.stringify(resp.data.data));
            resolve(resp.data.data); // 提取data中的内容
          } else {
            reject('查询书籍失败');
          }
        })
        .catch(error => {
          console.log('testTag', '查询书籍信息失败！error:', JSON.stringify(error));
          reject('查询书籍失败');
        });
    });
  }

  /**
   * 新增图书
   * @param book 新图书信息
   * @returns Promise<void>
   */
  addBook(book: listInfo): Promise<void> {
    return axios.post(`${this.baseURL}/book/create`, book)
      .then(resp => {
        if (resp.status === 201) {
          console.log('新增图书成功');
        } else {
          throw new Error('新增图书失败');
        }
      });
  }

  /**
   * 删除图书
   * @param id 图书ID
   * @returns Promise<void>
   */
  deleteBook(id: number): Promise<void> {
    return axios.delete(`${this.baseURL}/book/${id}`)
      .then(resp => {
        if (resp.status === 200) {
          console.log('删除图书成功');
        } else {
          throw new Error('删除图书失败');
        }
      });
  }
}

const book = new bookModel();
export default book;
