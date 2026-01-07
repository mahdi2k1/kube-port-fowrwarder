# kube-port-fowrwarder

اسکریپت ساده برای نگه داشتن پورت فورواردهای kubectl و اتصال مجدد در صورت قطع شدن.

## استفاده

1. مطمئن شوید `kubectl` روی سیستم نصب است و دسترسی به کلاستر دارید.
2. اسکریپت را اجرا کنید:

```bash
./port-forward.sh
```

## پیش‌فرض‌ها

- Namespace: `prod-story`
- پورت‌ها:
  - `svc/prod-story-psql-postgresql-ha` → `5454:5432`
  - `svc/prod-story-redis-haproxy` → `6363:6379`
  - `svc/reels-meilisearch` → `7700:7700`

اگر می‌خواهید مقادیر را تغییر دهید، آرایه `forwards` و متغیر `NAMESPACE` را در فایل `port-forward.sh` ویرایش کنید.
