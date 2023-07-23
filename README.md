# Project Title

ここにプロジェクトの説明を書いてください。

# Installation

以下の手順で、ローカルマシンにこのプロジェクトをセットアップできます。

```
Docker and Docker Compose
Docker version 20.10.6以上
Docker Compose version 1.29.1以上
```

このコマンドを実行してバージョンを確認してください。

```
docker -v
docker-compose -v
```

## Setup

GitHub リポジトリからクローンします。

```
git clone https://github.com/yourusername/yourrepository.git
```

プロジェクトのディレクトリに移動します。

```
cd yourrepository
```

Docker イメージをビルドします。初回または Dockerfile が変更された場合に必要です。

```
docker-compose build
```

依存関係をインストールします。

```
docker-compose run web bundle install
```

データベースを作成し、マイグレーションを実行します。

```
docker-compose run web rails db:create
docker-compose run web rails db:migrate
```

Docker Compose を使ってサービスを起動します。

```
docker-compose up
```

これで、アプリケーションが http://localhost:3000 で動作しているはずです。
