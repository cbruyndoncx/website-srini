/**
 * Custom JavaScript for Website Template
 * Handles theme toggling, form validation, navigation, and interactive features
 */

(function() {
    'use strict';

    // ========================================
    // Theme Toggle Functionality
    // ========================================

    function initThemeToggle() {
        const themeToggle = document.getElementById('themeToggle') || document.getElementById('theme-toggle');
        if (!themeToggle) return;

        const html = document.documentElement;
        const themeIcon = themeToggle.querySelector('i');

        // Load saved theme or default to light
        const savedTheme = localStorage.getItem('theme') || 'light';
        html.setAttribute('data-bs-theme', savedTheme);
        updateThemeIcon(savedTheme);

        function updateThemeIcon(theme) {
            if (!themeIcon) return;

            if (theme === 'dark') {
                themeIcon.classList.remove('bi-sun-fill');
                themeIcon.classList.add('bi-moon-fill');
            } else {
                themeIcon.classList.remove('bi-moon-fill');
                themeIcon.classList.add('bi-sun-fill');
            }
        }

        // Toggle theme on click
        themeToggle.addEventListener('click', function() {
            const currentTheme = html.getAttribute('data-bs-theme');
            const newTheme = currentTheme === 'light' ? 'dark' : 'light';
            html.setAttribute('data-bs-theme', newTheme);
            localStorage.setItem('theme', newTheme);
            updateThemeIcon(newTheme);
        });

        // Keyboard accessibility
        themeToggle.addEventListener('keypress', function(e) {
            if (e.key === 'Enter' || e.key === ' ') {
                e.preventDefault();
                themeToggle.click();
            }
        });
    }

    // ========================================
    // Active Navigation Highlighting
    // ========================================

    function initActiveNavigation() {
        const currentPage = window.location.pathname;
        const navLinks = document.querySelectorAll('.nav-link');

        navLinks.forEach(link => {
            const linkPath = new URL(link.href).pathname;

            // Remove active class from all links first
            link.classList.remove('active');
            link.removeAttribute('aria-current');

            // Add active class if paths match
            if (linkPath === currentPage ||
                (currentPage.includes(linkPath) && linkPath !== '/')) {
                link.classList.add('active');
                link.setAttribute('aria-current', 'page');
            }
        });
    }

    // ========================================
    // Smooth Scrolling for Anchor Links
    // ========================================

    function initSmoothScrolling() {
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
                const targetId = this.getAttribute('href');

                // Ignore if href is just "#"
                if (targetId === '#') return;

                const targetElement = document.querySelector(targetId);
                if (targetElement) {
                    e.preventDefault();
                    const navbarHeight = document.querySelector('.navbar')?.offsetHeight || 0;
                    const targetPosition = targetElement.offsetTop - navbarHeight;

                    window.scrollTo({
                        top: targetPosition,
                        behavior: 'smooth'
                    });
                }
            });
        });
    }

    // ========================================
    // Form Validation and Handling
    // ========================================

    function initFormValidation() {
        const forms = document.querySelectorAll('form[novalidate]');

        forms.forEach(form => {
            form.addEventListener('submit', function(event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    }

    // ========================================
    // Contact Form Handler
    // ========================================

    function initContactForm() {
        const contactForm = document.getElementById('contactForm');
        if (!contactForm) return;

        contactForm.addEventListener('submit', function(event) {
            event.preventDefault();
            event.stopPropagation();

            if (contactForm.checkValidity()) {
                // Collect form data
                const formData = {
                    name: document.getElementById('contactName')?.value,
                    email: document.getElementById('contactEmail')?.value,
                    phone: document.getElementById('contactPhone')?.value,
                    subject: document.getElementById('contactSubject')?.value,
                    message: document.getElementById('contactMessage')?.value,
                    newsletter: document.getElementById('newsletterOptIn')?.checked,
                    timestamp: new Date().toISOString()
                };

                // Save to localStorage (demo purposes)
                const contacts = JSON.parse(localStorage.getItem('contacts') || '[]');
                contacts.push(formData);
                localStorage.setItem('contacts', JSON.stringify(contacts));

                // Show success modal
                const successModal = document.getElementById('contactSuccessModal');
                if (successModal) {
                    const modal = new bootstrap.Modal(successModal);
                    modal.show();
                }

                // Reset form
                contactForm.reset();
                contactForm.classList.remove('was-validated');

                console.log('Contact form submitted:', formData);
            }

            contactForm.classList.add('was-validated');
        });
    }

    // ========================================
    // Booking Form Handler
    // ========================================

    function initBookingForm() {
        const bookingForm = document.getElementById('bookingForm');
        if (!bookingForm) return;

        // Set minimum date to today
        const serviceDateInput = document.getElementById('serviceDate');
        if (serviceDateInput) {
            const today = new Date().toISOString().split('T')[0];
            serviceDateInput.setAttribute('min', today);
        }

        // Handle "same as pickup" checkbox
        const sameAsPickupCheckbox = document.getElementById('sameAsPickup');
        const deliveryAddressSection = document.getElementById('deliveryAddressSection');

        if (sameAsPickupCheckbox && deliveryAddressSection) {
            sameAsPickupCheckbox.addEventListener('change', function() {
                if (this.checked) {
                    deliveryAddressSection.style.display = 'none';
                    // Remove required attribute from delivery fields
                    deliveryAddressSection.querySelectorAll('[required]').forEach(field => {
                        field.removeAttribute('required');
                        field.dataset.wasRequired = 'true';
                    });
                } else {
                    deliveryAddressSection.style.display = 'block';
                    // Restore required attribute
                    deliveryAddressSection.querySelectorAll('[data-was-required="true"]').forEach(field => {
                        field.setAttribute('required', '');
                    });
                }
            });
        }

        // Form submission
        bookingForm.addEventListener('submit', function(event) {
            event.preventDefault();
            event.stopPropagation();

            if (bookingForm.checkValidity()) {
                // Collect form data
                const formData = {
                    firstName: document.getElementById('firstName')?.value,
                    lastName: document.getElementById('lastName')?.value,
                    email: document.getElementById('email')?.value,
                    phone: document.getElementById('phone')?.value,
                    serviceType: document.getElementById('serviceType')?.value,
                    serviceDate: document.getElementById('serviceDate')?.value,
                    serviceTime: document.getElementById('serviceTime')?.value,
                    estimatedItems: document.getElementById('estimatedItems')?.value,
                    pickupAddress: document.getElementById('pickupAddress')?.value,
                    pickupCity: document.getElementById('pickupCity')?.value,
                    pickupState: document.getElementById('pickupState')?.value,
                    pickupZip: document.getElementById('pickupZip')?.value,
                    sameAsPickup: sameAsPickupCheckbox?.checked,
                    specialInstructions: document.getElementById('specialInstructions')?.value,
                    timestamp: new Date().toISOString()
                };

                // Add delivery address if different from pickup
                if (!sameAsPickupCheckbox?.checked) {
                    formData.deliveryAddress = document.getElementById('deliveryAddress')?.value;
                    formData.deliveryCity = document.getElementById('deliveryCity')?.value;
                    formData.deliveryState = document.getElementById('deliveryState')?.value;
                    formData.deliveryZip = document.getElementById('deliveryZip')?.value;
                }

                // Save to localStorage (demo purposes)
                const bookings = JSON.parse(localStorage.getItem('bookings') || '[]');
                bookings.push(formData);
                localStorage.setItem('bookings', JSON.stringify(bookings));

                // Show success modal
                const successModal = document.getElementById('successModal');
                if (successModal) {
                    const modal = new bootstrap.Modal(successModal);
                    modal.show();
                }

                // Reset form
                bookingForm.reset();
                bookingForm.classList.remove('was-validated');

                console.log('Booking form submitted:', formData);
            }

            bookingForm.classList.add('was-validated');
        });
    }

    // ========================================
    // Navbar Scroll Effect
    // ========================================

    function initNavbarScroll() {
        const navbar = document.querySelector('.navbar');
        if (!navbar) return;

        let lastScroll = 0;

        window.addEventListener('scroll', function() {
            const currentScroll = window.pageYOffset;

            // Add shadow on scroll
            if (currentScroll > 10) {
                navbar.classList.add('shadow');
            } else {
                navbar.classList.remove('shadow');
            }

            lastScroll = currentScroll;
        });
    }

    // ========================================
    // Image Lazy Loading (for older browsers)
    // ========================================

    function initLazyLoading() {
        if ('loading' in HTMLImageElement.prototype) {
            // Browser supports native lazy loading
            const images = document.querySelectorAll('img[data-src]');
            images.forEach(img => {
                img.src = img.dataset.src;
                img.removeAttribute('data-src');
            });
        } else {
            // Fallback for browsers that don't support lazy loading
            const images = document.querySelectorAll('img[data-src]');
            const imageObserver = new IntersectionObserver((entries, observer) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const img = entry.target;
                        img.src = img.dataset.src;
                        img.removeAttribute('data-src');
                        imageObserver.unobserve(img);
                    }
                });
            });

            images.forEach(img => imageObserver.observe(img));
        }
    }

    // ========================================
    // Scroll to Top Button
    // ========================================

    function initScrollToTop() {
        // Create scroll to top button if it doesn't exist
        let scrollBtn = document.getElementById('scrollToTop');

        if (!scrollBtn) {
            scrollBtn = document.createElement('button');
            scrollBtn.id = 'scrollToTop';
            scrollBtn.className = 'btn btn-primary position-fixed bottom-0 end-0 m-4 rounded-circle';
            scrollBtn.style.cssText = 'width: 50px; height: 50px; display: none; z-index: 1000;';
            scrollBtn.innerHTML = '<i class="bi bi-arrow-up"></i>';
            scrollBtn.setAttribute('aria-label', 'Scroll to top');
            document.body.appendChild(scrollBtn);
        }

        // Show/hide button on scroll
        window.addEventListener('scroll', function() {
            if (window.pageYOffset > 300) {
                scrollBtn.style.display = 'block';
            } else {
                scrollBtn.style.display = 'none';
            }
        });

        // Scroll to top on click
        scrollBtn.addEventListener('click', function() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    }

    // ========================================
    // Animate on Scroll (Simple Implementation)
    // ========================================

    function initAnimateOnScroll() {
        const animatedElements = document.querySelectorAll('.fade-in, .slide-in-left, .slide-in-right');

        if (animatedElements.length === 0) return;

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translate(0, 0)';
                }
            });
        }, {
            threshold: 0.1
        });

        animatedElements.forEach(el => {
            el.style.opacity = '0';
            observer.observe(el);
        });
    }

    // ========================================
    // Toast Notifications
    // ========================================

    function showToast(message, type = 'info') {
        const toastContainer = document.getElementById('toastContainer') || createToastContainer();

        const toastEl = document.createElement('div');
        toastEl.className = `toast align-items-center text-white bg-${type} border-0`;
        toastEl.setAttribute('role', 'alert');
        toastEl.setAttribute('aria-live', 'assertive');
        toastEl.setAttribute('aria-atomic', 'true');

        toastEl.innerHTML = `
            <div class="d-flex">
                <div class="toast-body">${message}</div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        `;

        toastContainer.appendChild(toastEl);

        const toast = new bootstrap.Toast(toastEl);
        toast.show();

        // Remove toast element after it's hidden
        toastEl.addEventListener('hidden.bs.toast', function() {
            toastEl.remove();
        });
    }

    function createToastContainer() {
        const container = document.createElement('div');
        container.id = 'toastContainer';
        container.className = 'toast-container position-fixed bottom-0 end-0 p-3';
        container.style.zIndex = '1100';
        document.body.appendChild(container);
        return container;
    }

    // Make showToast available globally
    window.showToast = showToast;

    // ========================================
    // Initialize All Functions on DOM Load
    // ========================================

    document.addEventListener('DOMContentLoaded', function() {
        initThemeToggle();
        initActiveNavigation();
        initSmoothScrolling();
        initFormValidation();
        initContactForm();
        initBookingForm();
        initNavbarScroll();
        initLazyLoading();
        initScrollToTop();
        initAnimateOnScroll();

        console.log('Website initialized successfully');
    });

    // ========================================
    // Service Worker Registration (if sw.js exists)
    // ========================================

    if ('serviceWorker' in navigator) {
        window.addEventListener('load', function() {
            navigator.serviceWorker.register('/sw.js')
                .then(function(registration) {
                    console.log('Service Worker registered successfully:', registration.scope);
                })
                .catch(function(error) {
                    console.log('Service Worker registration failed:', error);
                });
        });
    }

})();
