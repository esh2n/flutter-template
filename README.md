# xflutter_template

> Flutter + Firebaseテンプレートプロジェクト.

## 構成
> 上から下への依存関係(ただしInfra・Test層はDomain層より上 : DIP)

- Common : Providerなど共通部分
- Presentation : MVVMパターン、エンドポイント定義、一部Validation
- UseCase : Entity・Value Objectの生成・使用・永続化依頼、EntityからPresentation層に渡す値の変換
- Domain : Repository(Interface)、Entity・Value Object、Domain Service(ドメイン知識の表現)
- Infra : Repository(実装)、Entityの永続化・検索
- Test : テストコード(TODO)、Infraを交換することでテストが容易になる

## パッケージ
> TODO

## 使い方
> 前提 : Firebaseのプロジェクトを3つ(dev, stg, prod)作成の上、コンフィグファイル6つを用意しておく.

- [] アイコン書き出し: assets内を変更の上、`flutter pub run flutter_launcher_icons:main`
### ■ iOS
- [] `ios/${flavor}`ディレクトリにそれぞれ`GoogleService-Info.plist`を入れる.(既存のものと交換)

## 参考

- https://zenn.dev/riscait/articles/separating-environments-in-flutter#ios%E5%AF%BE%E5%BF%9C
- https://github.com/bannzai/Pilll (ディレクトリ構造を参考にしています)
- https://qiita.com/ko2ic/items/2a0aa4301011f8f52275#image_picker-06020