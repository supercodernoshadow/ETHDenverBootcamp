const { expect } = require('chai');
const { ethers } = require('hardhat');

describe("VolcanoCoin", ()=>{
	let token

	beforeEach(async () => {
		const Token = await ethers.getContractFactory('VolcanoCoin')
		token = await Token.deploy()

		accounts = await ethers.getSigners()
		deployer = accounts[0]
		user1 = accounts[1]
	})


	describe('Deployment', async() =>{
		const totalSupply = '10000'

		it('has correct total supply', async ()=>{
			expect(await token.tokenSupply()).to.equal(totalSupply)
		})
		
	})

	describe('Money Printing', async() =>{
		let transaction, result

		describe('Success', async() => {

			beforeEach(async()=> {
			transaction = await token.connect(deployer).print()
			result = await transaction.wait()
			totalSupply = '11000'

			})
			
			it('increases supply in 1,000 increments', async ()=>{
				expect(await token.tokenSupply()).to.equal(totalSupply)
			})
		})

		describe('Failure', async() => {

			it('only allows owner to print', async() => {
				expect(token.connect(user1).print()).to.be.reverted

			})
		})	
	})
})