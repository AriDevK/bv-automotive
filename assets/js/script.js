const button = document.querySelector('.menu-btn');
const nav = document.querySelector('.nav');
button?.addEventListener('click', () => { const open = nav.classList.toggle('open'); button.setAttribute('aria-expanded', String(open)); });
nav?.querySelectorAll('a').forEach(a => a.addEventListener('click', () => nav.classList.remove('open')));

const carousel = document.querySelector('[data-carousel]');
if (carousel) {
	const track = carousel.querySelector('.carousel-track');
	const slides = Array.from(carousel.querySelectorAll('.carousel-slide'));
	const prevBtn = carousel.querySelector('.carousel-control.prev');
	const nextBtn = carousel.querySelector('.carousel-control.next');
	const dots = Array.from(document.querySelectorAll('.carousel-dots button'));
	let index = 0;
	let autoplay = null;

	const render = () => {
		track.style.transform = `translateX(-${index * 100}%)`;
		slides.forEach((slide, i) => slide.classList.toggle('is-active', i === index));
		dots.forEach((dot, i) => dot.classList.toggle('is-active', i === index));
	};

	const goTo = (newIndex) => {
		index = (newIndex + slides.length) % slides.length;
		render();
	};

	const startAutoplay = () => {
		autoplay = window.setInterval(() => goTo(index + 1), 4500);
	};

	const stopAutoplay = () => {
		if (autoplay) window.clearInterval(autoplay);
	};

	prevBtn?.addEventListener('click', () => goTo(index - 1));
	nextBtn?.addEventListener('click', () => goTo(index + 1));
	dots.forEach((dot, i) => dot.addEventListener('click', () => goTo(i)));
	carousel.addEventListener('mouseenter', stopAutoplay);
	carousel.addEventListener('mouseleave', startAutoplay);

	render();
	startAutoplay();
}
