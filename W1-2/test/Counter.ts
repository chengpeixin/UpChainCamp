import {expect} from "chai";
import {ethers} from "hardhat";
import {Counter} from "../typechain-types";
import {BigNumber} from "ethers";

let counter: Counter;
describe("Counter", function () {
    const init = async () => {
        const [owner] = await ethers.getSigners();
        const Counter = await ethers.getContractFactory("Counter", owner);
        counter = await Counter.deploy();
        await counter.deployed();
        console.log(`counter deployed is success,address is ${counter.address}`)
    }

    before(async () => {
        await init();
    })

    it("Should add counter equal result", async function () {
        const defaultValue = await counter.getCounter();
        const addedValue = BigNumber.from("1");
        const rightResult = defaultValue.add(addedValue);
        const tx = await counter.add(addedValue);
        await tx.wait();
        const currentValue = await counter.getCounter();
        expect(currentValue).to.equal(rightResult);
    })

    it("Should call the other", async function () {
        const [owner, otherAccount] = await ethers.getSigners();
        let msg = ""
        try {
            await counter.connect(otherAccount).count()
        } catch (err) {
            msg = String(err);
        }
        expect(msg).to.have.string("You aren't the owner");
    })

    it("Should call the owner", async function () {
        const [owner] = await ethers.getSigners();
        const defaultVal = await counter.getCounter();
        await counter.connect(owner).count();
        const countedVal = await counter.getCounter();
        expect(countedVal).to.equal(defaultVal.add(1));
    })

});
