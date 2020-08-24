# 課題一覧
実装する機能等の一覧です。

## 一覧の表示

[Qiita API](https://qiita.com/api/v2/docs#%E6%8A%95%E7%A8%BF) の `/api/v2/items` に GET リクエストを送り、  
返ってきた記事のデータを `ItemsViewController` に表示してください。

また、セルに表示するデータは以下のようになっています。  
モデルオブジェクト作成の際に参考にしてください。

- ユーザーのアバター画像URL
- 記事のタイトル
- 記事の本文
- タグ一覧
- LGTM数
- コメント数
- 記事URL( 記事詳細へ遷移の際に使用します )

<details>
<summary>実装のヒント</summary>

以下は実装のヒントになります。  
実装の方針が分からない場合に参考にしてください。

### モデルオブジェクトの作成
API から返ってきたデータの構造を表すモデルオブジェクトを作成します。  
基本的にアプリ側から取得したデータを変更することはないので、`struct` で作成します。

また、JSON としてデータが返ってくる場合、  
`Decodable` に準拠させることで簡単に JSON から変換することができます。  
また `CodingKey` を使用してスネークケースからキャメルケースに変換することも可能です。

```Swift
struct SampleModel: Decodable {
    // ...
}

// JSON からの変換
do {
    let data = /* API から返ってきたデータ */
    let sampleModel = try try JSONDecoder().decode(SampleModel.self, from: data)
    print(sampleModel)
} catch {
    // デコードのエラー
    print(error)
}
```

### API 通信の実装
**Alamofire** を利用して API への通信処理を実装します。  
通信処理はビジネスロジックとなるため **Model** で実行します。  

**APIClient** のようなクラスを作成して、それを **Model** で実行する構成にすると再利用性が上がり、  
より良い構成になると思います。( [参考](https://qiita.com/ENDoDo/items/ab5c5edd5e07d6936743) )

### Model と ViewController 間のやりとりを実装
**Model** で得たデータを **ViewController** へ通知する処理を実装します。  
これには **Delegate** パターンを利用します。  

```Swift
// Model の delegate
protocol SampleModelDelegate: AnyObject {
    func sampleAction(with someData: Data)
}

final class SampleModel {
    // Model で delegate の通知先を弱参照で保持
    weak var delegate: SampleModelDelegate?
}

// ViewController
final class SampleViewController: UIViewController {

    // Model を保持
    private let model = SampleModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 簡易的なコードのため viewDidLoad 内に直接記載しています.
        // model の delegate の通知先に自身を設定
        model.delegate = self
    }
}

// delegate の通知先に設定したいため、delegate に準拠させる
extension SampleViewController: SampleModelDelegate {
    func sampleAction(with sampleData: Data) {
        // 引数から渡ってきたデータを利用した処理
    }
}
```

</details>

## ページネーションの実装

Qiita の API は[ページネーション](https://qiita.com/api/v2/docs#%E3%83%9A%E3%83%BC%E3%82%B8%E3%83%8D%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3)が実装されています。  
それを利用して記事一覧のテーブルを一番下までスクロールさせると次のページの記事を追加で読み込み、  
表示する機能を実装してください。

| ページネーションの動作 |
| :----------------: |
| ![Aug-24-2020 15-29-23](https://user-images.githubusercontent.com/31949692/91012882-cd3f2c00-e621-11ea-9a71-3d95183a9ded.gif) |

<details>
<summary>実装のヒント</summary>

TODO

</details>