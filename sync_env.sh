#!/bin/bash
# sync-env.sh
# Synchronize ~/.env.shared to all project repositories
# Place this at ~/projects/sync-env.sh

set -e

PROJECTS_DIR="$PWD"
SHARED_ENV="$PROJECTS_DIR/.env.shared"

sync_all() {
    echo "🔄 Syncing $SHARED_ENV to all projects..."

    count=0
    for repo_dir in "$PROJECTS_DIR"/*/; do
        if [ ! -d "$repo_dir" ]; then
            continue
        fi

        repo_name=$(basename "$repo_dir")

        if [[ "$repo_name" == .* ]]; then
            continue
        fi

        cp "$SHARED_ENV" "$repo_dir/.env"
        echo "✅ $repo_name"
        ((++count))
    done

    echo ""
    echo "✨ Done! Synced to $count project(s)"
}

# Check if shared env exists
if [ ! -f "$SHARED_ENV" ]; then
    echo "❌ Error: $SHARED_ENV not found!"
    echo "Please create it first with your shared environment variables."
    exit 1
fi

if [ "$1" = "--watch" ]; then
    echo "👀 Watching $SHARED_ENV for changes... (Ctrl+C to stop)"
    sync_all

    if command -v inotifywait >/dev/null 2>&1; then
        while inotifywait -q -e close_write,move,create,attrib "$SHARED_ENV"; do
            echo ""
            echo "📝 Change detected in .env.shared"
            sync_all
        done
    else
        echo "ℹ️ inotifywait not found, using polling every 2 seconds"
        last_mtime=$(stat -c %Y "$SHARED_ENV")
        while true; do
            sleep 2
            current_mtime=$(stat -c %Y "$SHARED_ENV")
            if [ "$current_mtime" != "$last_mtime" ]; then
                last_mtime="$current_mtime"
                echo ""
                echo "📝 Change detected in .env.shared"
                sync_all
            fi
        done
    fi
else
    sync_all
fi
