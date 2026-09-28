# Docker Infrastructure

Unified Docker infrastructure for PostgreSQL, MySQL, RabbitMQ, and MSSQL with centralized `.env` configuration.

## Services

| Service | Port | Image | Description |
|---------|------|-------|-------------|
| PostgreSQL | 5432 | `postgres:17-alpine` | Primary relational database |
| MySQL | 3306 | `mysql:8.0-alpine` | MySQL 8.0 database |
| RabbitMQ | 5672 / 15672 | `rabbitmq:4-management-alpine` | Message broker with management UI |
| MSSQL | 1433 | `mcr.microsoft.com/mssql/server:2022-latest` | Microsoft SQL Server 2022 |

All ports bind to `127.0.0.1` (localhost only) for security.

## Quick Start

### Using Docker Compose (Recommended)

```bash
# Start all services
docker compose up -d

# Start specific service
docker compose up -d postgres

# View logs
docker compose logs -f postgres

# Stop all services
docker compose down

# Stop and remove volumes (data loss!)
docker compose down -v
```

### Using Shell Scripts

Each service has an individual startup script that sources `.env`:

```bash
# Make executable (first time only)
chmod +x *.sh

# Start individual services
./postgres.sh
./mysql.sh
./rabbitmq.sh
./mssql.sh
```

## Configuration

All configuration is managed through `.env` file:

```bash
# Copy example and edit
cp .env.example .env  # if available, or edit .env directly
```

### Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| **PostgreSQL** | | |
| `POSTGRES_USER` | `postgres` | Superuser username |
| `POSTGRES_PASSWORD` | `postgres` | Superuser password |
| `POSTGRES_DB` | `postgres` | Default database name |
| **MySQL** | | |
| `MYSQL_ROOT_PASSWORD` | `root` | Root user password |
| `MYSQL_DATABASE` | `mysql` | Default database name |
| `MYSQL_USER` | `mysql` | Application user |
| `MYSQL_PASSWORD` | `root` | Application user password |
| **RabbitMQ** | | |
| `RABBITMQ_DEFAULT_USER` | `guest` | Default user |
| `RABBITMQ_DEFAULT_PASS` | `guest` | Default password |
| **MSSQL** | | |
| `MSSQL_SA_PASSWORD` | `mssql08Mei2005` | SA account password |
| **Redis** | | |
| `REDIS_PASSWORD` | `root` | Redis password (for future use) |

## Data Persistence

Each service uses named Docker volumes:

- `dms_postgres_data` → `/var/lib/postgresql/data`
- `dms_mysql_data` → `/var/lib/mysql`
- `dms_rabbitmq_data` → `/var/lib/rabbitmq`
- `dms_mssql_data` → `/var/opt/mssql`

Volumes persist across container restarts. Use `docker compose down -v` to remove them.

## Health Checks

All services include health checks:

```bash
# Check service health
docker compose ps

# Manual health check
docker exec postgres pg_isready -U postgres -d postgres
docker exec mysql mysqladmin ping -h localhost
docker exec rabbitmq rabbitmq-diagnostics -q ping
docker exec mssql /opt/mssql-tools18/bin/sqlcmd -C -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -Q 'SELECT 1'
```

## Resource Limits

| Service | CPU | Memory Limit | Memory Reservation |
|---------|-----|--------------|-------------------|
| PostgreSQL | 1.0 | 768 MB | 512 MB |
| MySQL | 0.75 | 512 MB | 256 MB |
| RabbitMQ | 0.5 | 512 MB | 256 MB |
| MSSQL | 1.5 | 2 GB | 1 GB |

## Security

- All containers run with `no-new-privileges:true`
- `init: true` for proper signal handling
- Ports bound to `127.0.0.1` only (not `0.0.0.0`)
- Non-root users where applicable (PostgreSQL, MySQL, RabbitMQ)
- Ulimits increased for file descriptors (65536)

## Network

All services share the `dms_backend` bridge network, enabling inter-service communication via container names.

## Logging

JSON file driver with rotation:
- Max size: 10 MB per file
- Max files: 3

## License

MIT