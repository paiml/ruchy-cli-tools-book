// Populate the sidebar
//
// This is a script, and not included directly in the page, to control the total size of the book.
// The TOC contains an entry for each page, so if each page includes a copy of the TOC,
// the total size of the page becomes O(n**2).
class MDBookSidebarScrollbox extends HTMLElement {
    constructor() {
        super();
    }
    connectedCallback() {
        this.innerHTML = '<ol class="chapter"><li class="chapter-item expanded affix "><a href="introduction.html">Introduction</a></li><li class="chapter-item expanded affix "><li class="part-title">Part I: Foundations</li><li class="chapter-item expanded "><a href="part1/01_getting_started.html"><strong aria-hidden="true">1.</strong> Getting Started with Ruchy</a></li><li class="chapter-item expanded "><a href="part1/02_extreme_tdd.html"><strong aria-hidden="true">2.</strong> EXTREME TDD Philosophy</a></li><li class="chapter-item expanded "><a href="part1/03_cli_basics.html"><strong aria-hidden="true">3.</strong> CLI Development Basics</a></li><li class="chapter-item expanded affix "><li class="part-title">Part II: Building Unix Classics</li><li class="chapter-item expanded "><a href="part2/01_cat.html"><strong aria-hidden="true">4.</strong> Chapter 1: ruchy-cat</a></li><li class="chapter-item expanded "><a href="part2/02_grep.html"><strong aria-hidden="true">5.</strong> Chapter 2: ruchy-grep</a></li><li class="chapter-item expanded "><a href="part2/03_wc.html"><strong aria-hidden="true">6.</strong> Chapter 3: ruchy-wc</a></li><li class="chapter-item expanded "><a href="part2/04_head.html"><strong aria-hidden="true">7.</strong> Chapter 4: ruchy-head</a></li><li class="chapter-item expanded affix "><li class="part-title">Part III: Advanced Topics</li><li class="chapter-item expanded "><a href="part3/01_testing.html"><strong aria-hidden="true">8.</strong> Testing Strategies</a></li><li class="chapter-item expanded "><a href="part3/02_mutation.html"><strong aria-hidden="true">9.</strong> Mutation Testing Deep Dive</a></li><li class="chapter-item expanded "><a href="part3/03_property.html"><strong aria-hidden="true">10.</strong> Property-Based Testing</a></li><li class="chapter-item expanded "><a href="part3/04_quality.html"><strong aria-hidden="true">11.</strong> Quality Gates</a></li><li class="chapter-item expanded "><a href="part3/05_performance.html"><strong aria-hidden="true">12.</strong> Performance &amp; Optimization</a></li><li class="chapter-item expanded affix "><li class="part-title">Part IV: The Toyota Way</li><li class="chapter-item expanded "><a href="part4/01_jidoka.html"><strong aria-hidden="true">13.</strong> Jidoka: Stop The Line</a></li><li class="chapter-item expanded "><a href="part4/02_genchi_genbutsu.html"><strong aria-hidden="true">14.</strong> Genchi Genbutsu: Go and See</a></li><li class="chapter-item expanded "><a href="part4/03_kaizen.html"><strong aria-hidden="true">15.</strong> Kaizen: Continuous Improvement</a></li><li class="chapter-item expanded "><a href="part4/04_respect.html"><strong aria-hidden="true">16.</strong> Respect for People</a></li><li class="chapter-item expanded affix "><li class="part-title">Appendices</li><li class="chapter-item expanded "><a href="appendix/a_language_reference.html"><strong aria-hidden="true">17.</strong> Appendix A: Ruchy Language Reference</a></li><li class="chapter-item expanded "><a href="appendix/b_unix_tools.html"><strong aria-hidden="true">18.</strong> Appendix B: Unix Tool Reference</a></li><li class="chapter-item expanded "><a href="appendix/c_testing_patterns.html"><strong aria-hidden="true">19.</strong> Appendix C: Testing Patterns</a></li><li class="chapter-item expanded "><a href="appendix/d_quality_metrics.html"><strong aria-hidden="true">20.</strong> Appendix D: Quality Metrics</a></li><li class="chapter-item expanded "><a href="appendix/e_troubleshooting.html"><strong aria-hidden="true">21.</strong> Appendix E: Troubleshooting</a></li><li class="chapter-item expanded affix "><li class="spacer"></li><li class="chapter-item expanded affix "><a href="contributors.html">Contributors</a></li><li class="chapter-item expanded affix "><a href="references.html">References</a></li></ol>';
        // Set the current, active page, and reveal it if it's hidden
        let current_page = document.location.href.toString();
        if (current_page.endsWith("/")) {
            current_page += "index.html";
        }
        var links = Array.prototype.slice.call(this.querySelectorAll("a"));
        var l = links.length;
        for (var i = 0; i < l; ++i) {
            var link = links[i];
            var href = link.getAttribute("href");
            if (href && !href.startsWith("#") && !/^(?:[a-z+]+:)?\/\//.test(href)) {
                link.href = path_to_root + href;
            }
            // The "index" page is supposed to alias the first chapter in the book.
            if (link.href === current_page || (i === 0 && path_to_root === "" && current_page.endsWith("/index.html"))) {
                link.classList.add("active");
                var parent = link.parentElement;
                if (parent && parent.classList.contains("chapter-item")) {
                    parent.classList.add("expanded");
                }
                while (parent) {
                    if (parent.tagName === "LI" && parent.previousElementSibling) {
                        if (parent.previousElementSibling.classList.contains("chapter-item")) {
                            parent.previousElementSibling.classList.add("expanded");
                        }
                    }
                    parent = parent.parentElement;
                }
            }
        }
        // Track and set sidebar scroll position
        this.addEventListener('click', function(e) {
            if (e.target.tagName === 'A') {
                sessionStorage.setItem('sidebar-scroll', this.scrollTop);
            }
        }, { passive: true });
        var sidebarScrollTop = sessionStorage.getItem('sidebar-scroll');
        sessionStorage.removeItem('sidebar-scroll');
        if (sidebarScrollTop) {
            // preserve sidebar scroll position when navigating via links within sidebar
            this.scrollTop = sidebarScrollTop;
        } else {
            // scroll sidebar to current active section when navigating via "next/previous chapter" buttons
            var activeSection = document.querySelector('#sidebar .active');
            if (activeSection) {
                activeSection.scrollIntoView({ block: 'center' });
            }
        }
        // Toggle buttons
        var sidebarAnchorToggles = document.querySelectorAll('#sidebar a.toggle');
        function toggleSection(ev) {
            ev.currentTarget.parentElement.classList.toggle('expanded');
        }
        Array.from(sidebarAnchorToggles).forEach(function (el) {
            el.addEventListener('click', toggleSection);
        });
    }
}
window.customElements.define("mdbook-sidebar-scrollbox", MDBookSidebarScrollbox);
