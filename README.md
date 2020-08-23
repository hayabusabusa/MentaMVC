## MentaMVC
MVC ( Model - ViewController ) 練習課題のリポジトリです。

## 概要

[Qiita API](https://qiita.com/api/v2/docs#%E6%A6%82%E8%A6%81) を使用して記事一覧を取得します。  
画面は一覧画面と記事詳細画面( SFSafariViewController )の2画面です。

| 一覧画面 | 詳細画面 |
| :-----: | :-----: |
| ![Simulator Screen Shot - iPhone 11 - 2020-08-23 at 15 21 15](https://user-images.githubusercontent.com/31949692/90973175-715da000-e55a-11ea-9889-20d15b17a497.png) | ![Simulator Screen Shot - iPhone 11 - 2020-08-23 at 15 22 04](https://user-images.githubusercontent.com/31949692/90973180-7cb0cb80-e55a-11ea-9a6f-17a0e22a8200.png) |

## 事前準備

### アクセストークンの追加

Qiita のアクセストークンが必要になります。  
以下のコマンドを実行してアクセストークンをプロジェクトに追加してください。

```
make inject-token TOKEN=#YOUR_TOKEN#
```

### Carthage

ライブラリを Carthage で管理しているので、以下のコマンドで取得してください。

```
carthage bootstrap --platform iOS
```
