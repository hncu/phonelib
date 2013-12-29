package phonelibv2



import org.junit.*
import grails.test.mixin.*

@TestFor(BorrowController)
@Mock(Borrow)
class BorrowControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/borrow/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.borrowInstanceList.size() == 0
        assert model.borrowInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.borrowInstance != null
    }

    void testSave() {
        controller.save()

        assert model.borrowInstance != null
        assert view == '/borrow/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/borrow/show/1'
        assert controller.flash.message != null
        assert Borrow.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/borrow/list'


        populateValidParams(params)
        def borrow = new Borrow(params)

        assert borrow.save() != null

        params.id = borrow.id

        def model = controller.show()

        assert model.borrowInstance == borrow
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/borrow/list'


        populateValidParams(params)
        def borrow = new Borrow(params)

        assert borrow.save() != null

        params.id = borrow.id

        def model = controller.edit()

        assert model.borrowInstance == borrow
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/borrow/list'

        response.reset()


        populateValidParams(params)
        def borrow = new Borrow(params)

        assert borrow.save() != null

        // test invalid parameters in update
        params.id = borrow.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/borrow/edit"
        assert model.borrowInstance != null

        borrow.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/borrow/show/$borrow.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        borrow.clearErrors()

        populateValidParams(params)
        params.id = borrow.id
        params.version = -1
        controller.update()

        assert view == "/borrow/edit"
        assert model.borrowInstance != null
        assert model.borrowInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/borrow/list'

        response.reset()

        populateValidParams(params)
        def borrow = new Borrow(params)

        assert borrow.save() != null
        assert Borrow.count() == 1

        params.id = borrow.id

        controller.delete()

        assert Borrow.count() == 0
        assert Borrow.get(borrow.id) == null
        assert response.redirectedUrl == '/borrow/list'
    }
}
