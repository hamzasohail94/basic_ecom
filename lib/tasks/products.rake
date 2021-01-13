namespace :products do
  task seed: :environment do
    100.times do
      product = Product.create(name: "Product##{rand.to_s[2...5]}", quantity: 10, price: 100)
      file_name = (1..10).to_a.sample.to_s + '.jpeg'
      product.image.attach(io: File.open(Rails.root.join('public', 'sample', file_name)), filename: file_name)
    end
  end
end
