/**
 * Service Worker for Progressive Web App
 * Handles caching and offline functionality
 */

const CACHE_NAME = 'site-cache-v1';
const RUNTIME_CACHE = 'runtime-cache-v1';

// Assets to cache on install
const STATIC_ASSETS = [
    '/',
    '/index.html',
    '/pages/services.html',
    '/pages/booking.html',
    '/pages/contact.html',
    '/assets/css/custom.css',
    '/assets/js/custom.js',
    '/manifest.json',
    // Add Bootstrap CDN files
    'https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css',
    'https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js',
    'https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css'
];

// Install event - cache static assets
self.addEventListener('install', event => {
    console.log('Service Worker installing...');

    event.waitUntil(
        caches.open(CACHE_NAME)
            .then(cache => {
                console.log('Caching static assets');
                return cache.addAll(STATIC_ASSETS);
            })
            .then(() => self.skipWaiting())
            .catch(error => {
                console.error('Failed to cache static assets:', error);
            })
    );
});

// Activate event - clean up old caches
self.addEventListener('activate', event => {
    console.log('Service Worker activating...');

    event.waitUntil(
        caches.keys()
            .then(cacheNames => {
                return Promise.all(
                    cacheNames
                        .filter(cacheName => {
                            return cacheName !== CACHE_NAME && cacheName !== RUNTIME_CACHE;
                        })
                        .map(cacheName => {
                            console.log('Deleting old cache:', cacheName);
                            return caches.delete(cacheName);
                        })
                );
            })
            .then(() => self.clients.claim())
    );
});

// Fetch event - serve from cache, fallback to network
self.addEventListener('fetch', event => {
    const { request } = event;
    const url = new URL(request.url);

    // Skip cross-origin requests
    if (url.origin !== location.origin && !url.href.includes('cdn.jsdelivr.net')) {
        return;
    }

    // Different strategies for different types of requests
    if (request.method === 'GET') {
        // Cache-first strategy for static assets
        if (isStaticAsset(request.url)) {
            event.respondWith(cacheFirst(request));
        }
        // Network-first strategy for HTML pages
        else if (request.headers.get('accept').includes('text/html')) {
            event.respondWith(networkFirst(request));
        }
        // Network-first for other resources
        else {
            event.respondWith(networkFirst(request));
        }
    }
});

// Cache-first strategy
async function cacheFirst(request) {
    const cachedResponse = await caches.match(request);

    if (cachedResponse) {
        return cachedResponse;
    }

    try {
        const networkResponse = await fetch(request);

        if (networkResponse.ok) {
            const cache = await caches.open(RUNTIME_CACHE);
            cache.put(request, networkResponse.clone());
        }

        return networkResponse;
    } catch (error) {
        console.error('Fetch failed:', error);

        // Return offline page for navigation requests
        if (request.mode === 'navigate') {
            return caches.match('/offline.html');
        }

        throw error;
    }
}

// Network-first strategy
async function networkFirst(request) {
    try {
        const networkResponse = await fetch(request);

        if (networkResponse.ok) {
            const cache = await caches.open(RUNTIME_CACHE);
            cache.put(request, networkResponse.clone());
        }

        return networkResponse;
    } catch (error) {
        console.error('Network request failed, trying cache:', error);

        const cachedResponse = await caches.match(request);

        if (cachedResponse) {
            return cachedResponse;
        }

        // Return offline page for navigation requests
        if (request.mode === 'navigate') {
            return caches.match('/offline.html');
        }

        throw error;
    }
}

// Check if request is for a static asset
function isStaticAsset(url) {
    return url.endsWith('.css') ||
           url.endsWith('.js') ||
           url.endsWith('.png') ||
           url.endsWith('.jpg') ||
           url.endsWith('.jpeg') ||
           url.endsWith('.svg') ||
           url.endsWith('.gif') ||
           url.endsWith('.webp') ||
           url.endsWith('.woff') ||
           url.endsWith('.woff2') ||
           url.endsWith('.ttf') ||
           url.endsWith('.eot');
}

// Listen for messages from the client
self.addEventListener('message', event => {
    if (event.data && event.data.type === 'SKIP_WAITING') {
        self.skipWaiting();
    }

    if (event.data && event.data.type === 'CLEAR_CACHE') {
        event.waitUntil(
            caches.keys().then(cacheNames => {
                return Promise.all(
                    cacheNames.map(cacheName => caches.delete(cacheName))
                );
            }).then(() => {
                return self.clients.matchAll();
            }).then(clients => {
                clients.forEach(client => {
                    client.postMessage({ type: 'CACHE_CLEARED' });
                });
            })
        );
    }
});

// Background sync (if supported)
self.addEventListener('sync', event => {
    console.log('Background sync event:', event.tag);

    if (event.tag === 'sync-bookings') {
        event.waitUntil(syncBookings());
    }

    if (event.tag === 'sync-contacts') {
        event.waitUntil(syncContacts());
    }
});

// Sync bookings from localStorage to server (when backend is available)
async function syncBookings() {
    try {
        // This would send data to your backend API
        // For now, it's just a placeholder
        console.log('Syncing bookings...');

        // const bookings = await getStoredBookings();
        // await fetch('/api/bookings', {
        //     method: 'POST',
        //     headers: { 'Content-Type': 'application/json' },
        //     body: JSON.stringify(bookings)
        // });

        return Promise.resolve();
    } catch (error) {
        console.error('Failed to sync bookings:', error);
        return Promise.reject(error);
    }
}

// Sync contacts from localStorage to server (when backend is available)
async function syncContacts() {
    try {
        console.log('Syncing contacts...');

        // const contacts = await getStoredContacts();
        // await fetch('/api/contacts', {
        //     method: 'POST',
        //     headers: { 'Content-Type': 'application/json' },
        //     body: JSON.stringify(contacts)
        // });

        return Promise.resolve();
    } catch (error) {
        console.error('Failed to sync contacts:', error);
        return Promise.reject(error);
    }
}

// Push notification event (if implementing push notifications)
self.addEventListener('push', event => {
    if (!event.data) return;

    const data = event.data.json();

    const options = {
        body: data.body || 'New notification',
        icon: '/assets/images/icons/icon-192x192.png',
        badge: '/assets/images/icons/icon-96x96.png',
        vibrate: [200, 100, 200],
        data: {
            url: data.url || '/'
        }
    };

    event.waitUntil(
        self.registration.showNotification(data.title || 'Notification', options)
    );
});

// Notification click event
self.addEventListener('notificationclick', event => {
    event.notification.close();

    event.waitUntil(
        clients.openWindow(event.notification.data.url || '/')
    );
});

console.log('Service Worker loaded');
