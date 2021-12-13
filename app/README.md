# xflutter_template

> Flutter + Firebaseテンプレートプロジェクト.

## ■ 前提

- Firebaseプロジェクトを３つ(prod, stg, dev)作成の上コンフィグファイルを計6つ用意
- Bundle IDを確定させておく

## ■ Usage

1. `git clone [https://github.com/esh2n/xflutter-template](https://github.com/esh2n/xflutter-template) your_project_name`
2. アイコン書き出し: assets内を変更の上、`flutter pub run flutter_launcher_icons:main`
3. Firebase : `ios/${flavor}` ディレクトリにそれぞれ  `GoogleService-Info.plist` を入れる.
4. FIrebase : `android/app/src/${flavor}` にそれぞれ `google-services.json` を入れる.
5. Android : `app/build.gradle` 内のdefaultConfig.resValueをBundle IDに変更
6. Android : ディレクトリ構造・MainActivity.ktをBundle IDに変更
7. iOS : Bundle IDを変更
8. ビルド確認

## ■ Directory

> 上から下への依存関係(ただしInfra・Test層はDomain層より上 : DIP)
>
- 00_common : Providerなど共通部分
- 01_presentation : MVVMパターン、エンドポイント定義、一部Validation
- 02_usecase : Entity・Value Objectの生成・使用・永続化依頼、EntityからPresentation層に渡す値の変換
- 03_domain : Repository(Interface)、Entity・Value Object、Domain Service(ドメイン知識の表現)
- 04_infra : Repository(実装)、Entityの永続化・検索
- test : テストコード(TODO)、Infraを交換することでテストが容易になる

## ■ 推奨コード規約

1. 基本的にはStatefullWidgetは使わない
2. constを極力使うように(re-render防止)
3. ページに対し1:1でProviderを持たせるよりも機能単位で持たせるべき
4. DIP原則に乗っ取り上から下への依存関係の徹底(上が交換可能)
    1. アプリケーション層に書かれたものを[ドメイン](http://d.hatena.ne.jp/keyword/%A5%C9%A5%E1%A5%A4%A5%F3)モデルが使うのはダメだけれど逆は OK
5. lintエラーはない状態にする

## ■ 起動コマンド

```jsx
flutter run --dart-define=FLAVOR=dev
flutter run --dart-define=FLAVOR=stg
flutter run --dart-define=FLAVOR=prod
```

## ■ TODO

- 一括環境構築用スクリプト
- CI/CD追加
- FirebaseCloudMessagingなどよく使うであろう機能もつけておく(別ブランチで対応もあり)

## ■ 参考

- [https://zenn.dev/riscait/articles/separating-environments-in-flutter#ios%E5%AF%BE%E5%BF%9C](https://zenn.dev/riscait/articles/separating-environments-in-flutter#ios%E5%AF%BE%E5%BF%9C)
- [https://github.com/bannzai/Pilll](https://github.com/bannzai/Pilll) (ディレクトリ構造を参考にしています)
- [https://qiita.com/ko2ic/items/2a0aa4301011f8f52275#image_picker-06020](https://qiita.com/ko2ic/items/2a0aa4301011f8f52275#image_picker-06020)
