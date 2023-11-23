<?php
  session_start();
  include "../database.php";
 ?>

<html>
	<head>
		<title>Inventory</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
		<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
	</head>
	<body class="is-preload">

		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Header -->
					<header id="header">
						<div class="logo">
							<span class="icon fa-gem"></span>
						</div>
						<div class="content">
							<div class="inner">
								<h1>Inventory Management</h1>
								<!--<p>A fully responsive site template designed by <a href="https://html5up.net">HTML5 UP</a> and released<br />
								for free under the <a href="https://html5up.net/license">Creative Commons</a> license.</p>-->
							</div>
						</div>
						<nav>
							<ul>
								<li><a href="#inventory">Inventory</a></li>
								<li><a href="#purchases">Purchases</a></li>
								<li><a href="#orders">Orders</a></li>
								<!--<li><a href="#contact">Contact</a></li>-->
								<!--<li><a href="#elements">Elements</a></li>-->
							</ul>
						</nav>
					</header>

				<!-- Main -->
					<div id="main">

						<!-- Intro -->
							<article id="inventory">
								<h2 class="major">Inventory</h2>
                <div class="alert">
                  <?php echo isset($alert) ? $alert: '';?>
                </div>
								<table>
                  <tr>
                    <th>ID</th>
                    <th>Product Name</th>
                    <th>Purchase Quantity</th>
                    <th>Order Quantity</th>
                    <th>Current Stock</th>
                    <th>Options</th>
                  </tr>
                  <?php

                  $store_id = $_SESSION['store'];
                  $query = mysqli_query($conection, "SELECT i.inventory_id, p.product_name, i.purchase_quantity, i.order_quantity, i.current_stock FROM inventory i INNER JOIN product p ON i.product_id = p.product_id INNER JOIN store s ON i.store_id = s.store_id WHERE i.store_id = '$store_id' ");
                  $result = mysqli_num_rows($query);
                    if ($result > 0) {
                      while ($data = mysqli_fetch_array($query)) {

                    ?>
                      <tr>
                        <td><?php echo $data["inventory_id"]; ?></td>
                        <td><?php echo $data["product_name"]; ?></td>
                        <td><?php echo $data["purchase_quantity"];?></td>
                        <td><?php echo $data["order_quantity"]; ?></td>
                        <td><?php echo $data["current_stock"]; ?></td>
                        <td>
                          <a class="link_edit" href="#">Edit</a>
                          <a class="link_delete" href="#">Delete</a>
                        </td>
                      </tr>

                    <?php
                      }
                    }
                   ?>
                </table>
							</article>

						<!-- Work -->
							<article id="purchases">
								<h2 class="major">Purchases</h2>
                <table>
                  <tr>
                    <th>ID</th>
                    <th>Product Name</th>
                    <th>Purchased Quantity</th>
                    <th>Purchase Date</th>
                    <th>Options</th>
                  </tr>
                  <?php
                  $store_id = $_SESSION['store'];
                  $query = mysqli_query($conection, "SELECT p.purchase_id, q.product_name, p.purchased_quantity, p.purchase_date FROM purchase p INNER JOIN product q ON p.product_id = q.product_id INNER JOIN store s ON p.store_id = s.store_id WHERE p.store_id = '$store_id'");
                  $result = mysqli_num_rows($query);
                    if ($result > 0) {
                      while ($data = mysqli_fetch_array($query)) {

                    ?>
                      <tr>
                        <td><?php echo $data["purchase_id"]; ?></td>
                        <td><?php echo $data["product_name"]; ?></td>
                        <td><?php echo $data["purchased_quantity"];?></td>
                        <td><?php echo $data["purchase_date"]; ?></td>
                        <td>
                          <a class="link_edit" href="#">Edit</a>
                          <a class="link_delete" href="#">Delete</a>
                        </td>
                      </tr>

                    <?php
                      }
                    }
                   ?>
                </table>

							</article>

						<!-- About -->
							<article id="orders">
								<h2 class="major">Orders</h2>
                <table>
                  <tr>
                    <th>ID</th>
                    <th>Product Name</th>
                    <th>Order Quantity</th>
                    <th>Order Date</th>
                    <th>Options</th>
                  </tr>
                  <?php
                  $store_id = $_SESSION['store'];
                  $query = mysqli_query($conection, "SELECT o.order_id, q.product_name, o.ordered_quantity, o.order_date FROM orders o INNER JOIN product q ON o.product_id = q.product_id INNER JOIN store s ON o.store_id = s.store_id WHERE o.store_id ='$store_id'");
                  $result = mysqli_num_rows($query);
                    if ($result > 0) {
                      while ($data = mysqli_fetch_array($query)) {

                    ?>
                      <tr>
                        <td><?php echo $data["order_id"]; ?></td>
                        <td><?php echo $data["product_name"]; ?></td>
                        <td><?php echo $data["ordered_quantity"];?></td>
                        <td><?php echo $data["order_date"]; ?></td>
                        <td>
                          <a class="link_edit" href="#">Edit</a>
                          <a class="link_delete" href="#">Delete</a>
                        </td>
                      </tr>

                    <?php
                      }
                    }
                   ?>
                </table>
							</article>



						<!-- Elements -->
							<article id="elements">
								<h2 class="major">Elements</h2>

								<section>
									<h3 class="major">Text</h3>
									<p>This is <b>bold</b> and this is <strong>strong</strong>. This is <i>italic</i> and this is <em>emphasized</em>.
									This is <sup>superscript</sup> text and this is <sub>subscript</sub> text.
									This is <u>underlined</u> and this is code: <code>for (;;) { ... }</code>. Finally, <a href="#">this is a link</a>.</p>
									<hr />
									<h2>Heading Level 2</h2>
									<h3>Heading Level 3</h3>
									<h4>Heading Level 4</h4>
									<h5>Heading Level 5</h5>
									<h6>Heading Level 6</h6>
									<hr />
									<h4>Blockquote</h4>
									<blockquote>Fringilla nisl. Donec accumsan interdum nisi, quis tincidunt felis sagittis eget tempus euismod. Vestibulum ante ipsum primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan faucibus. Vestibulum ante ipsum primis in faucibus lorem ipsum dolor sit amet nullam adipiscing eu felis.</blockquote>
									<h4>Preformatted</h4>
									<pre><code>i = 0;

while (!deck.isInOrder()) {
    print 'Iteration ' + i;
    deck.shuffle();
    i++;
}

print 'It took ' + i + ' iterations to sort the deck.';</code></pre>
								</section>

								<section>
									<h3 class="major">Lists</h3>

									<h4>Unordered</h4>
									<ul>
										<li>Dolor pulvinar etiam.</li>
										<li>Sagittis adipiscing.</li>
										<li>Felis enim feugiat.</li>
									</ul>

									<h4>Alternate</h4>
									<ul class="alt">
										<li>Dolor pulvinar etiam.</li>
										<li>Sagittis adipiscing.</li>
										<li>Felis enim feugiat.</li>
									</ul>

									<h4>Ordered</h4>
									<ol>
										<li>Dolor pulvinar etiam.</li>
										<li>Etiam vel felis viverra.</li>
										<li>Felis enim feugiat.</li>
										<li>Dolor pulvinar etiam.</li>
										<li>Etiam vel felis lorem.</li>
										<li>Felis enim et feugiat.</li>
									</ol>
									<h4>Icons</h4>
									<ul class="icons">
										<li><a href="#" class="icon brands fa-twitter"><span class="label">Twitter</span></a></li>
										<li><a href="#" class="icon brands fa-facebook-f"><span class="label">Facebook</span></a></li>
										<li><a href="#" class="icon brands fa-instagram"><span class="label">Instagram</span></a></li>
										<li><a href="#" class="icon brands fa-github"><span class="label">Github</span></a></li>
									</ul>

									<h4>Actions</h4>
									<ul class="actions">
										<li><a href="#" class="button primary">Default</a></li>
										<li><a href="#" class="button">Default</a></li>
									</ul>
									<ul class="actions stacked">
										<li><a href="#" class="button primary">Default</a></li>
										<li><a href="#" class="button">Default</a></li>
									</ul>
								</section>

								<section>
									<h3 class="major">Table</h3>
									<h4>Default</h4>
									<div class="table-wrapper">
										<table>
											<thead>
												<tr>
													<th>Name</th>
													<th>Description</th>
													<th>Price</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>Item One</td>
													<td>Ante turpis integer aliquet porttitor.</td>
													<td>29.99</td>
												</tr>
												<tr>
													<td>Item Two</td>
													<td>Vis ac commodo adipiscing arcu aliquet.</td>
													<td>19.99</td>
												</tr>
												<tr>
													<td>Item Three</td>
													<td> Morbi faucibus arcu accumsan lorem.</td>
													<td>29.99</td>
												</tr>
												<tr>
													<td>Item Four</td>
													<td>Vitae integer tempus condimentum.</td>
													<td>19.99</td>
												</tr>
												<tr>
													<td>Item Five</td>
													<td>Ante turpis integer aliquet porttitor.</td>
													<td>29.99</td>
												</tr>
											</tbody>
											<tfoot>
												<tr>
													<td colspan="2"></td>
													<td>100.00</td>
												</tr>
											</tfoot>
										</table>
									</div>

									<h4>Alternate</h4>
									<div class="table-wrapper">
										<table class="alt">
											<thead>
												<tr>
													<th>Name</th>
													<th>Description</th>
													<th>Price</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>Item One</td>
													<td>Ante turpis integer aliquet porttitor.</td>
													<td>29.99</td>
												</tr>
												<tr>
													<td>Item Two</td>
													<td>Vis ac commodo adipiscing arcu aliquet.</td>
													<td>19.99</td>
												</tr>
												<tr>
													<td>Item Three</td>
													<td> Morbi faucibus arcu accumsan lorem.</td>
													<td>29.99</td>
												</tr>
												<tr>
													<td>Item Four</td>
													<td>Vitae integer tempus condimentum.</td>
													<td>19.99</td>
												</tr>
												<tr>
													<td>Item Five</td>
													<td>Ante turpis integer aliquet porttitor.</td>
													<td>29.99</td>
												</tr>
											</tbody>
											<tfoot>
												<tr>
													<td colspan="2"></td>
													<td>100.00</td>
												</tr>
											</tfoot>
										</table>
									</div>
								</section>

								<section>
									<h3 class="major">Buttons</h3>
									<ul class="actions">
										<li><a href="#" class="button primary">Primary</a></li>
										<li><a href="#" class="button">Default</a></li>
									</ul>
									<ul class="actions">
										<li><a href="#" class="button">Default</a></li>
										<li><a href="#" class="button small">Small</a></li>
									</ul>
									<ul class="actions">
										<li><a href="#" class="button primary icon solid fa-download">Icon</a></li>
										<li><a href="#" class="button icon solid fa-download">Icon</a></li>
									</ul>
									<ul class="actions">
										<li><span class="button primary disabled">Disabled</span></li>
										<li><span class="button disabled">Disabled</span></li>
									</ul>
								</section>

								<section>
									<h3 class="major">Form</h3>
									<form method="post" action="#">
										<div class="fields">
											<div class="field half">
												<label for="demo-name">Name</label>
												<input type="text" name="demo-name" id="demo-name" value="" placeholder="Jane Doe" />
											</div>
											<div class="field half">
												<label for="demo-email">Email</label>
												<input type="email" name="demo-email" id="demo-email" value="" placeholder="jane@untitled.tld" />
											</div>
											<div class="field">
												<label for="demo-category">Category</label>
												<select name="demo-category" id="demo-category">
													<option value="">-</option>
													<option value="1">Manufacturing</option>
													<option value="1">Shipping</option>
													<option value="1">Administration</option>
													<option value="1">Human Resources</option>
												</select>
											</div>
											<div class="field half">
												<input type="radio" id="demo-priority-low" name="demo-priority" checked>
												<label for="demo-priority-low">Low</label>
											</div>
											<div class="field half">
												<input type="radio" id="demo-priority-high" name="demo-priority">
												<label for="demo-priority-high">High</label>
											</div>
											<div class="field half">
												<input type="checkbox" id="demo-copy" name="demo-copy">
												<label for="demo-copy">Email me a copy</label>
											</div>
											<div class="field half">
												<input type="checkbox" id="demo-human" name="demo-human" checked>
												<label for="demo-human">Not a robot</label>
											</div>
											<div class="field">
												<label for="demo-message">Message</label>
												<textarea name="demo-message" id="demo-message" placeholder="Enter your message" rows="6"></textarea>
											</div>
										</div>
										<ul class="actions">
											<li><input type="submit" value="Send Message" class="primary" /></li>
											<li><input type="reset" value="Reset" /></li>
										</ul>
									</form>
								</section>

							</article>

					</div>

				<!-- Footer -->
					<footer id="footer">
						<p class="copyright">Group 1</p>
					</footer>

			</div>

		<!-- BG -->
			<div id="bg"></div>

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/browser.min.js"></script>
			<script src="assets/js/breakpoints.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

	</body>
</html>
