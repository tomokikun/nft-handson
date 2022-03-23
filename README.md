# nft-handson
NFTをローカル環境で動かしてみるハンズオンです。

# 🐳 準備
- Dockerを使うので、入ってない場合はインストールしてください。

# 🎨 ハンズオン
## 1. イントロダクション
### ブロックチェーン
TODO: ブロックチェーンの説明追加 <br/>

### スマートコントラクト
TODO: スマートコントラクトの説明追加 <br/>

### 今回のハンズオンで利用するツール紹介

名前| 概要
-- | --
[ganache](https://www.trufflesuite.com/docs/ganache/overview)　| ローカルで開発用のprivateブロックチェーンを構築
[truffle](https://trufflesuite.com/) | スマートコントラクトの開発ツール（デプロイ、テストなど）

## 2. 環境構築
まずは、開発環境を整えていきます。

1. 本レポジトリをクローン
   - `git clone git@github.com:tomokikun/nft-handson.git`
2. Dockerコンテナを起動
   - `docker-compose up` 
     - Imageをビルドした後、`truffle`コンテナと`ganache`コンテナが起動するはず。
     - TODO: ganacheコンテナのログの内容の説明
3. 別のターミナルを立ち上げる 
   - コンテナ内に入って作業する用です
4. `truffle`コンテナに入る
   - `docker exec -it nft-handson_truffle_1 sh` 
   - （コンテナ名が異なる場合、`docker ps`で確認してください）
5. truffleの確認
   - `truffle -v`
6. truffleでテンプレートを生成
   - `truffle init`
   - 以下のようなテンプレートが生成されるはず。
    ```
    truffle
    ├── contracts
    │   └── Migrations.sol
    ├── migrations
    │   └── 1_initial_migration.js
    ├── test
    └── truffle-config.js
    ```
    TODO: 生成されたファイルの説明
7. `truffle-config.js`のnetworks内の`development`部分のコメントアウトを外し、`host`を`127.0.0.1`から`ganache`に変更
    ```
    ...(略)
    networks: {
        ...(略)
        development: {
            host: "ganache", // Localhost (default: none)
            port: 8545, // Standard Ethereum port (default: none)
            network_id: "*", // Any network (default: none)
        },
        ...(略)
    }
    ...(略)
    ```
    - `ganache`とコンテナ名を指定すると、`docker-compose`が自動的にIPアドレスに解決してくれます。
8. ganacheの疎通確認
    - `truffle console` 
      - ```truffle(development)>```と表示されたら成功
      - ganacheコンテナもログを出力しているはず
    - `ctrl + d`でtruffleのコンソールから離脱

以上で準備完了です。

## 3. スマートコントラクトでHello World

TODO: スマートコントラクトの説明

1. コントラクトを作成
    - `truffle create contract HelloWorld`
2. `contracts/HelloWorld.sol`に以下と置き換える
   ```sol
    // SPDX-License-Identifier: MIT
    pragma solidity >=0.4.22 <0.9.0;

    contract HelloWorld {
        string greeting;

        constructor() {
            greeting = "Hello, Smart Contract!";
        }

        function getMessage() public view returns (string memory) {
            return greeting;
        }
    }
    ```
3. コントラクトをデプロイするスクリプトを作成
    - `truffle create migration HelloWorld`
        - `migrations/xxxxxxxxxx_hello_world.js`のようなファイルが生成させる
4. `migrations/xxxxxxxxxx_hello_world.js`を以下のように書き換える
    ```
    const HelloWorld = artifacts.require("HelloWorld");
    module.exports = function (_deployer) {
      // Use deployer to state migration tasks.
      _deployer.deploy(HelloWorld);
    };
    ```
5. デプロイ
    - `truffle migrate`
6. コントラクトのメソッドをコール
    - `truffle console` 
    - truffle console内で`const helloWorld = await HelloWorld.deployed()`
    - truffle console内で`helloWorld.getMessage()`
        - 以下のように表示されたら成功です！🎉
            ```
            truffle(development)> helloWorld.getMessage()
            'Hello, Smart Contract!'
            ```

7. おまけ: ETHが減っていることを確認
ganacheを起動した時は100あったETHがデプロイによって少し減っていることが確認できます。
```
truffle(development)> const accounts = await web3.eth.getAccounts()
truffle(development)> const balance = await web3.eth.getBalance(accounts[0])
truffle(development)> await web3.utils.fromWei(balance)
'99.98961646'
```

## 4. NFTを書く
準備中

## 5. テストネットにデプロイ
準備中

# 📚 学習リソース
より学びたい人のために、参考になる資料をまとめます。

- https://docs.soliditylang.org/
- https://cryptozombies.io/jp/

TODO: 資料追加
