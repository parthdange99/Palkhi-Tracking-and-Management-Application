<h2><?= esc($title) ?></h2>

<?php if (!empty($news_list)): ?>
    <?php foreach ($news_list as $news_item): ?>
        <h3><?= esc($news_item['title']) ?></h3>
        <div class="main">
            <?= esc($news_item['body']) ?>
        </div>
        <p><a href="/news/<?= esc($news_item['slug'], 'url') ?>">View article</a></p>
    <?php endforeach; ?>
<?php else: ?>
    <p>No News found</p>
<?php endif; ?>
