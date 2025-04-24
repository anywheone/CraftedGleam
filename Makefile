# Makefile

# 依存関係変更時
reset:
	docker-compose down --volumes --remove-orphans
	docker-compose build --no-cache
	docker-compose up -d

# コード修正時
rebuild:
	docker-compose down --remove-orphans
	docker-compose up -d --build

# コンテナ起動
up:
	docker-compose up -d

# コンテナ停止
down:
	docker-compose down --volumes --remove-orphans

# コンテナの状態確認
status:
	docker-compose ps

# コンテナログ確認
logs:
	docker-compose logs

# 各コンテナにシェル接続
shell-frontend:
	cd frontend && docker-compose exec frontend sh

shell-backend:
	cd backend && docker-compose exec backend sh

shell-ai:
	cd ai && docker-compose exec ai sh

# DBにpsqlで接続
psql:
	docker exec -it postgres_craftedgleam psql -U craftedgleam_user -d craftedgleam

# ディスク容量の使用状況確認
disk:
	docker system df

# 重要なデータを守りつつ、定期クリーンアップ
# 1. 未使用のイメージ、停止中のコンテナ、未使用のネットワーク、ビルドキャッシュを削除
# 2. ボリューム、実行中のコンテナ、タグ付きイメージは削除しない
prune:
	docker system prune --volumes=false